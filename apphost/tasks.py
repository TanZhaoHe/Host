import random
import string
from celery import shared_task
from django.contrib.auth.hashers import make_password
# from .models import Host
# apphost/tasks.py
from host1.celery import app as celery_app


from django.db.models import Count
from django.utils import timezone
from .models import Host, City, MachineRoom, HostStatistics
# @shared_task
@celery_app.task
def update_all_host_passwords():
    """遍历所有主机，生成随机密码并加密存储"""
    # 生成随机密码（示例：8位，包含大小写字母、数字、特殊字符）
    chars = string.ascii_letters + string.digits + '!@#$%^&*()'
    for host in Host.objects.all():
        # 生成随机密码
        new_password = ''.join(random.choice(chars) for _ in range(12))  # 12位随机密码

        # 加密存储（用 Django 的密码哈希算法）
        host.password = make_password(new_password)  # 假设 Host 模型有 password 字段
        host.save()

        # -------- 可选：实际执行 SSH 等方式修改主机真实密码 --------
        # 这里需要你实现具体的“远程修改密码”逻辑，比如用 paramiko 连接主机
        # 示例（伪代码）：
        # import paramiko
        # ssh = paramiko.SSHClient()
        # ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # ssh.connect(host.ip_address, username='root', password='旧密码', port=22)
        # stdin, stdout, stderr = ssh.exec_command(f'echo "root:{new_password}" | chpasswd')
        # 注意：实际要处理异常、旧密码获取等问题，需结合你的主机管理逻辑

    return f"Updated {Host.objects.count()} hosts' passwords"

# @shared_task
@celery_app.task
def daily_host_statistics():
    try:
        today = timezone.now().date()
        statistic_time = timezone.make_aware(
            timezone.datetime(today.year, today.month, today.day, 0, 0, 0)
        )

        # 按城市+机房分组统计（使用正确的关联路径）
        queryset = Host.objects.values(
            'machine_room__city__id', 'machine_room__city__name',  # 城市维度（通过machine_room关联）
            'machine_room__id', 'machine_room__name',  # 机房维度
        ).annotate(
            host_count=Count('id')
        ).order_by('machine_room__city__id', 'machine_room__id')

        for item in queryset:
            city_id = item['machine_room__city__id']
            city_name = item['machine_room__city__name']
            room_id = item['machine_room__id']
            room_name = item['machine_room__name']
            count = item['host_count']

            # 获取城市和机房实例
            city = City.objects.get(id=city_id)
            room = MachineRoom.objects.get(id=room_id)

            # 创建或更新统计记录
            HostStatistics.objects.update_or_create(
                city=city,
                room=room,
                statistic_time=statistic_time,
                defaults={'host_count': count}
            )

        return f"Daily statistics completed. Total groups: {len(queryset)}"
    except Exception as e:
        # 记录错误日志
        from django.core.mail import mail_admins
        mail_admins('统计任务失败', str(e))
        return f"Error: {str(e)}"