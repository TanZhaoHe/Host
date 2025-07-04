# Generated by Django 5.2.3 on 2025-06-29 10:26

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="City",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "name",
                    models.CharField(
                        max_length=50, unique=True, verbose_name="城市名称"
                    ),
                ),
                (
                    "code",
                    models.CharField(
                        blank=True, max_length=20, null=True, verbose_name="城市编码"
                    ),
                ),
                (
                    "description",
                    models.TextField(blank=True, null=True, verbose_name="描述"),
                ),
            ],
            options={
                "verbose_name": "城市",
                "verbose_name_plural": "城市列表",
            },
        ),
        migrations.CreateModel(
            name="MachineRoom",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=50, verbose_name="机房名称")),
                ("address", models.CharField(max_length=200, verbose_name="详细地址")),
                (
                    "contact",
                    models.CharField(
                        blank=True, max_length=50, null=True, verbose_name="联系人"
                    ),
                ),
                (
                    "phone",
                    models.CharField(
                        blank=True, max_length=20, null=True, verbose_name="联系电话"
                    ),
                ),
                (
                    "city",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="machine_rooms",
                        to="apphost.city",
                    ),
                ),
            ],
            options={
                "verbose_name": "机房",
                "verbose_name_plural": "机房列表",
                "unique_together": {("name", "city")},
            },
        ),
        migrations.CreateModel(
            name="Host",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "hostname",
                    models.CharField(
                        max_length=100, unique=True, verbose_name="主机名"
                    ),
                ),
                (
                    "ip_address",
                    models.GenericIPAddressField(unique=True, verbose_name="IP地址"),
                ),
                (
                    "status",
                    models.CharField(
                        choices=[
                            ("online", "在线"),
                            ("offline", "离线"),
                            ("unknown", "未知"),
                        ],
                        default="unknown",
                        max_length=20,
                        verbose_name="状态",
                    ),
                ),
                (
                    "cpu_info",
                    models.CharField(
                        blank=True, max_length=100, null=True, verbose_name="CPU信息"
                    ),
                ),
                (
                    "memory",
                    models.CharField(
                        blank=True, max_length=50, null=True, verbose_name="内存"
                    ),
                ),
                (
                    "disk",
                    models.CharField(
                        blank=True, max_length=100, null=True, verbose_name="磁盘"
                    ),
                ),
                (
                    "os",
                    models.CharField(
                        blank=True, max_length=100, null=True, verbose_name="操作系统"
                    ),
                ),
                (
                    "created_at",
                    models.DateTimeField(auto_now_add=True, verbose_name="创建时间"),
                ),
                (
                    "updated_at",
                    models.DateTimeField(auto_now=True, verbose_name="更新时间"),
                ),
                (
                    "machine_room",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="hosts",
                        to="apphost.machineroom",
                    ),
                ),
            ],
            options={
                "verbose_name": "主机",
                "verbose_name_plural": "主机列表",
            },
        ),
    ]
