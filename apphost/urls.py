# from django.urls import path, include
# from rest_framework.routers import DefaultRouter
# from .views import CityViewSet, MachineRoomViewSet, HostViewSet, HostPingViewSet
#
# router = DefaultRouter()
# router.register(r'cities', CityViewSet)
# router.register(r'machine-rooms', MachineRoomViewSet)
# router.register(r'hosts', HostViewSet)
#
# urlpatterns = [
#     path('', include(router.urls)),
#     path('hosts/<int:pk>/ping/', HostPingViewSet.as_view({'get': 'retrieve'}), name='host-ping'),
# ]
#
# from django.urls import path, include
# from rest_framework.routers import DefaultRouter
# from .views import (
#     CityViewSet,
#     MachineRoomViewSet,
#     HostViewSet,
#     HostPingViewSet
# )
#
# # 1. 初始化路由
# router = DefaultRouter()
#
# # 2. 注册常规 CRUD 接口
# router.register(r'cities', CityViewSet)
# router.register(r'machine-rooms', MachineRoomViewSet)
# router.register(r'hosts', HostViewSet)
#
# # 3. 给 Host 注册额外动作（推荐用这种方式管理关联接口）
# # 效果：/hosts/{pk}/ping/ 会自动关联到 HostPingViewSet
# router.register(
#     r'hosts',
#     HostViewSet,
#     basename='host'
# ).register(
#     r'ping',
#     HostPingViewSet,
#     basename='host-ping',
#     parents_query_lookups=['pk']
# )
#
# urlpatterns = [
#     # 4. 直接包含路由，所有接口由 router 统一管理
#     path('', include(router.urls)),
# ]

# from django.urls import path, include
# from rest_framework.routers import DefaultRouter
# from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
#
# from .views import (
#     CityViewSet,
#     MachineRoomViewSet,
#     HostViewSet,
#     HostPingViewSet
# )
#
# # 主路由配置
# router = DefaultRouter(trailing_slash=False)
# router.register(r'cities', CityViewSet, basename='city')
# router.register(r'machine-rooms', MachineRoomViewSet, basename='machine-room')
#
# # 只注册一次 HostViewSet（关键！）
# router.register(r'hosts', HostViewSet, basename='host')
#
# # 嵌套注册ping接口（不再重复注册HostViewSet）
# # 直接在已注册的hosts路由下添加子路由
# router.register(
#     r'hosts',  # 必须与已注册的hosts前缀一致
#     HostViewSet,
#     basename='host'
# ).register(
#     r'(?P<pk>\d+)/ping',
#     HostPingViewSet,
#     basename='host-ping',
#     parents_query_lookups=['pk']
# )
#
# urlpatterns = [
#     path('schema/', SpectacularAPIView.as_view(), name='api-schema'),
#     path('docs/', SpectacularSwaggerView.as_view(url_name='api-schema'), name='api-docs'),
#     path('', include(router.urls)),
# ]

# from django.urls import path, include
# from rest_framework.routers import DefaultRouter
# from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
#
# from .views import (
#     CityViewSet,
#     MachineRoomViewSet,
#     HostViewSet
# )
#
# # 主路由配置
# router = DefaultRouter(trailing_slash=False)
# router.register(r'cities', CityViewSet, basename='city')
# router.register(r'machine-rooms', MachineRoomViewSet, basename='machine-room')
# router.register(r'hosts', HostViewSet, basename='host')  # 只注册一次HostViewSet
#
# urlpatterns = [
#     path('schema/', SpectacularAPIView.as_view(), name='api-schema'),
#     path('docs/', SpectacularSwaggerView.as_view(url_name='api-schema'), name='api-docs'),
#     path('', include(router.urls)),
# ]

# apphost/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

from .views import CityViewSet, MachineRoomViewSet, HostViewSet

router = DefaultRouter()
router.register(r'cities', CityViewSet, basename='city')
router.register(r'machine-rooms', MachineRoomViewSet, basename='machine-room')

router.register(r'hosts', HostViewSet, basename='host')
urlpatterns = [
    path('schema/', SpectacularAPIView.as_view(), name='api-schema'),
    path('docs/', SpectacularSwaggerView.as_view(url_name='api-schema'), name='api-docs'),
    path('', include(router.urls)),
]