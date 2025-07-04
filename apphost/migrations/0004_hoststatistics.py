# Generated by Django 5.2.3 on 2025-06-30 07:07

import django.db.models.deletion
import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("apphost", "0003_alter_host_password"),
    ]

    operations = [
        migrations.CreateModel(
            name="HostStatistics",
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
                ("host_count", models.IntegerField(default=0, verbose_name="主机数量")),
                (
                    "statistic_time",
                    models.DateTimeField(
                        default=django.utils.timezone.now, verbose_name="统计时间"
                    ),
                ),
                (
                    "city",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="apphost.city",
                        verbose_name="所属城市",
                    ),
                ),
                (
                    "room",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="apphost.machineroom",
                        verbose_name="所属机房",
                    ),
                ),
            ],
            options={
                "verbose_name": "主机统计结果",
                "verbose_name_plural": "主机统计结果",
                "unique_together": {("city", "room", "statistic_time")},
            },
        ),
    ]
