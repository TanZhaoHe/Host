# from django.shortcuts import render
#
# # Create your views here.
# from rest_framework import viewsets, permissions, status
# from rest_framework.response import Response
# from django.shortcuts import get_object_or_404
# import subprocess
# import platform
# from .models import City, MachineRoom, Host
# from .serializers import CitySerializer, MachineRoomSerializer, HostSerializer
#
#
# class CityViewSet(viewsets.ModelViewSet):
#     queryset = City.objects.all()
#     serializer_class = CitySerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly]
#
#
# class MachineRoomViewSet(viewsets.ModelViewSet):
#     queryset = MachineRoom.objects.all()
#     serializer_class = MachineRoomSerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly]
#
#     def get_queryset(self):
#         queryset = super().get_queryset()
#         city_id = self.request.query_params.get('city_id')
#         if city_id:
#             queryset = queryset.filter(city_id=city_id)
#         return queryset
#
#
# class HostViewSet(viewsets.ModelViewSet):
#     queryset = Host.objects.all()
#     serializer_class = HostSerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly]
#
#     def get_queryset(self):
#         queryset = super().get_queryset()
#         room_id = self.request.query_params.get('room_id')
#         status = self.request.query_params.get('status')
#
#         if room_id:
#             queryset = queryset.filter(machine_room_id=room_id)
#         if status:
#             queryset = queryset.filter(status=status)
#         return queryset
#
#
# class HostPingViewSet(viewsets.ViewSet):
#     permission_classes = [permissions.IsAuthenticated]
#
#     def retrieve(self, request, pk=None):
#         host = get_object_or_404(Host, pk=pk)
#         result = self._ping_host(host.ip_address)
#
#         host.status = 'online' if result['success'] else 'offline'
#         host.save()
#
#         return Response({
#             'host_id': host.id,
#             'ip_address': host.ip_address,
#             'status': host.status,
#             'ping_result': result
#         }, status=status.HTTP_200_OK)
#
#     def _ping_host(self, ip, count=4):
#         param = '-n' if platform.system().lower() == 'windows' else '-c'
#         command = ['ping', param, str(count), ip]
#
#         try:
#             result = subprocess.run(
#                 command,
#                 stdout=subprocess.PIPE,
#                 stderr=subprocess.PIPE,
#                 timeout=5
#             )
#             success = result.returncode == 0
#
#             return {
#                 'success': success,
#                 'stdout': result.stdout.decode('utf-8', errors='ignore'),
#                 'stderr': result.stderr.decode('utf-8', errors='ignore'),
#                 'return_code': result.returncode
#             }
#         except subprocess.TimeoutExpired:
#             return {
#                 'success': False,
#                 'error': 'Ping timed out',
#                 'return_code': -1
#             }
#         except Exception as e:
#             return {
#                 'success': False,
#                 'error': str(e),
#                 'return_code': -1
#             }

from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404
import subprocess
import platform
from .models import City, MachineRoom, Host
from .serializers import CitySerializer, MachineRoomSerializer, HostSerializer

from rest_framework.permissions import AllowAny
# 在项目中添加一个视图来打印路由
from django.urls import get_resolver
from django.http import HttpResponse
import json


class CityViewSet(viewsets.ModelViewSet):
    queryset = City.objects.all()
    serializer_class = CitySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]


class MachineRoomViewSet(viewsets.ModelViewSet):
    queryset = MachineRoom.objects.all()
    serializer_class = MachineRoomSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        city_id = self.request.query_params.get('city_id')
        if city_id:
            queryset = queryset.filter(city_id=city_id)
        return queryset


class HostViewSet(viewsets.ModelViewSet):
    queryset = Host.objects.all()
    serializer_class = HostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        room_id = self.request.query_params.get('room_id')
        status = self.request.query_params.get('status')

        if room_id:
            queryset = queryset.filter(machine_room_id=room_id)
        if status:
            queryset = queryset.filter(status=status)
        return queryset

    @action(detail=True, methods=['get'], permission_classes=[AllowAny])
    def ping(self, request, pk=None):
        """执行主机Ping探测"""
        host = get_object_or_404(Host, pk=pk)
        result = self._ping_host(host.ip_address)

        host.status = 'online' if result['success'] else 'offline'
        host.save()

        return Response({
            'host_id': host.id,
            'ip_address': host.ip_address,
            'status': host.status,
            'ping_result': result
        }, status=status.HTTP_200_OK)

    def _ping_host(self, ip, count=4):
        """执行Ping命令并返回结果"""
        param = '-n' if platform.system().lower() == 'windows' else '-c'
        command = ['ping', param, str(count), ip]

        try:
            result = subprocess.run(
                command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=5
            )
            success = result.returncode == 0

            return {
                'success': success,
                'stdout': result.stdout.decode('utf-8', errors='ignore'),
                'stderr': result.stderr.decode('utf-8', errors='ignore'),
                'return_code': result.returncode
            }
        except subprocess.TimeoutExpired:
            return {
                'success': False,
                'error': 'Ping timed out',
                'return_code': -1
            }
        except Exception as e:
            return {
                'success': False,
                'error': str(e),
                'return_code': -1
            }

