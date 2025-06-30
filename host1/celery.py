import os
from celery import Celery

# 设置 Django 项目默认设置模块
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'host1.settings')

app = Celery('host1')

# 从 Django 设置中加载 Celery 配置
app.config_from_object('django.conf:settings', namespace='CELERY')

# 自动发现所有 Django app 中的 tasks.py
app.autodiscover_tasks()



@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')