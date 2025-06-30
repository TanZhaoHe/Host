主机管理系统



系统概述



主机管理系统是一个IT 基础设施管理平台，用于集中管理企业内部的主机资源、机房信息和城市分布


功能使用指南



### 1. 管理后台使用&#xA;



1.  **访问后台**：启动服务后访问 `http://localhost:8000/admin/`

2.  **登录**：使用创建的超级用户账号登录（首次运行需执行 `python ``manage.py`` createsuperuser`）


3.  **资源管理**：


*   在 "城市" 模块添加企业主机所在城市


*   在 "机房" 模块关联城市并添加机房信息


*   在 "主机" 模块录入主机详情及登录密码


### 2. 自动化密码更新&#xA;

##注意，测试中把时间改为了十秒，修改为8小时将10改为60*60*8即可

*   **定时任务**：系统默认每 8 小时自动更新所有主机密码（可在配置中修改更新频率）


*   **手动触发**：如需立即更新，可执行：




```
python manage.py shell
>>> from apphost.tasks import update_all_host_passwords
>>> result = update_all_host_passwords.delay()
>>> result.status  # 应显示 'SUCCESS'
```






### 3. 主机统计&#xA;



*   **自动统计**：每日 00:00 自动按城市和机房统计主机数量


*   **结果查询**：在管理后台的 "主机数量统计" 模块查看历史统计数据


*   **手动实时统计**：

```
python manage.py shell
>>> from apphost.tasks import daily_host_statistics
>>> result = daily_host_statistics.delay()
>>> print(result.get())
```





### 4. API 接口使用&#xA;



*   **查看文档**：访问 `http://127.0.0.1:8000/docs/` 查看交互式 API 文档






系统部署步骤



### 1. 环境准备&#xA;



*   Python 3.8+


*   MySQL 8.0（创建数据库 `db05`）


*   Redis 6.0+（作为 Celery 消息队列）




5.  **初始化数据库**：


```
python manage.py makemigrations


python manage.py migrate
```

### 3. 启动服务&#xA;



*   **启动 Web 服务**：`python ``manage.py`` runserver`

*   **启动任务服务**：




```
\# 启动Celery任务处理器（Windows环境）


celery -A host1 worker --loglevel=info --pool=solo


\# 启动定时任务调度器


celery -A host1 beat --loglevel=info
```


核心功能说明



### 1. 主机资源层级管理&#xA;



*   **城市管理**：维护企业主机所在的城市信息，支持添加、修改和查询城市编码与描述


*   **机房管理**：按城市划分机房，记录机房地址、联系人等信息，支持多机房集中管理


*   **主机管理**：记录主机名、IP 地址、硬件配置（CPU / 内存 / 磁盘）、操作系统等信息，支持主机状态（在线 / 离线）管理


### 2. 主机密码自动化管理&#xA;



*   **密码安全存储**：使用 PBKDF2 加密算法存储主机密码，避免明文泄露


*   **定时自动更新**：每隔 8 小时自动生成强密码（包含大小写字母、数字和特殊字符），并通过 SSH 协议远程更新主机密码


*   **密码历史记录**：保存密码变更历史，支持审计追踪和版本查询


### 3. 资源统计与分析&#xA;



*   **每日自动统计**：每天 00:00 按城市和机房维度统计主机数量，结果存入数据库


*   **实时性能监控**：通过中间件记录每个请求的耗时、路径和状态码，支持性能瓶颈分析


*   **日志系统**：分模块记录操作日志、任务日志和错误日志，便于问题排查


### 4. 标准化 API 接口&#xA;



*   **RESTful API**：提供城市、机房、主机的增删改查接口，符合 REST 规范


*   **网络探测接口**：支持通过 API 探测主机 Ping 可达性，返回实时网络状态


*   **接口文档**：自动生成 Swagger 格式 API 文档，支持交互式接口测试


功能实现截图

![image](https://github.com/user-attachments/assets/5789dc5a-5019-4d85-8208-74bccf3fca2c)

![image](https://github.com/user-attachments/assets/d08ca520-0a0d-4af1-af50-282e83343222)

![image](https://github.com/user-attachments/assets/059bbff2-6405-4324-8854-f5e93e7d4a0b)

![image](https://github.com/user-attachments/assets/86131d5d-4fdf-4638-8a29-48b521f843d1)

![image](https://github.com/user-attachments/assets/90122b21-65ee-43f6-9b35-c34ab0a94fb8)

![image](https://github.com/user-attachments/assets/a15772d1-d4ad-4b3f-add7-b1591c87bb73)

![image](https://github.com/user-attachments/assets/08f9f332-5dac-4175-97cc-e4cc8f63329d)

![image](https://github.com/user-attachments/assets/ddbb8b25-ddff-4545-b540-a44875f8dfdc)













