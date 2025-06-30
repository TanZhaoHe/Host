from django.contrib.auth.hashers import make_password, check_password
from django.db import models
from django.utils import timezone
# Create your models here.
from django.utils.translation import gettext_lazy as _


class City(models.Model):
    """城市模型：存储主机所在城市信息"""
    name = models.CharField(_("城市名称"), max_length=50, unique=True)
    code = models.CharField(_("城市编码"), max_length=20, blank=True, null=True)
    description = models.TextField(_("描述"), blank=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = _("城市")
        verbose_name_plural = _("城市列表")


class MachineRoom(models.Model):
    """机房模型：存储主机所在机房信息"""
    name = models.CharField(_("机房名称"), max_length=50)
    # 城市字段，使用外键关联到 City 模型
    city = models.ForeignKey(City, on_delete=models.CASCADE, related_name="machine_rooms", db_index=True)
    address = models.CharField(_("详细地址"), max_length=200)
    contact = models.CharField(_("联系人"), max_length=50, blank=True, null=True)
    phone = models.CharField(_("联系电话"), max_length=20, blank=True, null=True)

    def __str__(self):
        return f"{self.city.name}-{self.name}"

    class Meta:
        verbose_name = _("机房")
        verbose_name_plural = _("机房列表")
        unique_together = ('name', 'city')


class Host(models.Model):
    """主机模型：存储主机详细信息"""

    class HostStatus(models.TextChoices):
        ONLINE = 'online', _('在线')
        OFFLINE = 'offline', _('离线')
        UNKNOWN = 'unknown', _('未知')

    hostname = models.CharField(_("主机名"), max_length=100, unique=True)
    ip_address = models.GenericIPAddressField(_("IP地址"), unique=True)
    machine_room = models.ForeignKey(MachineRoom, on_delete=models.SET_NULL,
                                     related_name="hosts", blank=True, null=True, db_index=True)
    status = models.CharField(_("状态"), max_length=20, choices=HostStatus.choices,
                              default=HostStatus.UNKNOWN)
    cpu_info = models.CharField(_("CPU信息"), max_length=100, blank=True, null=True)
    memory = models.CharField(_("内存"), max_length=50, blank=True, null=True)
    disk = models.CharField(_("磁盘"), max_length=100, blank=True, null=True)
    os = models.CharField(_("操作系统"), max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(_("创建时间"), auto_now_add=True)
    updated_at = models.DateTimeField(_("更新时间"), auto_now=True)

    # 新增密码字段 ↓
    password = models.CharField(_("主机密码"), max_length=128, blank=True, null=True)  # 改为128长度存储哈希值

    def set_password(self, raw_password):
        """加密明文密码并存储"""
        self.password = make_password(raw_password)

    def check_password(self, raw_password):
        """验证密码是否正确"""
        return check_password(raw_password, self.password)

    def __str__(self):
        return f"{self.hostname}({self.ip_address})"

    class Meta:
        verbose_name = _("主机")
        verbose_name_plural = _("主机列表")




class HostStatistics(models.Model):
    city = models.ForeignKey('City', on_delete=models.CASCADE, verbose_name='所属城市')
    room = models.ForeignKey('MachineRoom', on_delete=models.CASCADE, verbose_name='所属机房')
    host_count = models.IntegerField(default=0, verbose_name='主机数量')
    statistic_time = models.DateTimeField(default=timezone.now, verbose_name='统计时间')

    class Meta:
        verbose_name = '主机统计结果'
        verbose_name_plural = '主机统计结果'
        # 确保同一城市+机房+统计日唯一（可选，避免重复统计）
        unique_together = ('city', 'room', 'statistic_time')