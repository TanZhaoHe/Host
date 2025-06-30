# import time
# import logging
# from django.http import HttpRequest, HttpResponse
#
# logger = logging.getLogger('request_time')
#
#
# class RequestTimeMiddleware:
#     def __init__(self, get_response):
#         self.get_response = get_response
#
#     def __call__(self, request: HttpRequest):
#         start_time = time.time()
#
#         try:
#             response = self.get_response(request)
#         except Exception as e:
#             duration = (time.time() - start_time) * 1000
#             logger.error(
#                 f"path={request.path} method={request.method} status=500 "
#                 f"duration={duration:.2f}ms error={str(e)}"
#             )
#             raise
#
#         duration = (time.time() - start_time) * 1000
#
#         # 统一使用日志记录器，根据配置决定输出位置
#         if response.status_code >= 400:
#             logger.warning(
#                 f"path={request.path} method={request.method} status={response.status_code} "
#                 f"duration={duration:.2f}ms"
#             )
#         else:
#             logger.info(
#                 f"path={request.path} method={request.method} status={response.status_code} "
#                 f"duration={duration:.2f}ms"
#             )
#
#         response['X-Request-Time'] = f"{duration:.2f}ms"
#         return response


import time
import logging
from django.http import HttpRequest, HttpResponse

# 确保使用正确的日志记录器名称
logger = logging.getLogger('request_time')

class RequestTimeMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request: HttpRequest):
        # 记录请求开始时间
        start_time = time.time()

        # 处理请求，获取响应
        response = self.get_response(request)

        # 计算请求耗时（毫秒）
        duration = (time.time() - start_time) * 1000

        # 记录日志（可根据需求调整日志级别和格式）
        print(f"请求路径: {request.path} | 耗时: {duration:.2f}ms | 状态码: {response.status_code}")

        # 可选：将耗时信息添加到响应头中
        response['X-Request-Time'] = f"{duration:.2f}ms"

        # # 记录到日志（使用 request_time 日志器）
        # logger.info(
        #     f"路径: {request.path} | 方法: {request.method} | 耗时: {duration:.2f}ms | 状态: {response.status_code}")



        return response