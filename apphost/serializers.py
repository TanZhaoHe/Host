from rest_framework import serializers
from .models import City, MachineRoom, Host

class CitySerializer(serializers.ModelSerializer):
    class Meta:
        model = City
        fields = '__all__'

class MachineRoomSerializer(serializers.ModelSerializer):
    city_name = serializers.ReadOnlyField(source='city.name')
    class Meta:
        model = MachineRoom
        fields = '__all__'

class HostSerializer(serializers.ModelSerializer):
    city_name = serializers.ReadOnlyField(source='machine_room.city.name')
    room_name = serializers.ReadOnlyField(source='machine_room.name')

    def create(self, validated_data):
        """创建主机时加密密码"""
        password = validated_data.pop('password', None)
        host = Host.objects.create(**validated_data)
        if password:
            host.set_password(password)
            host.save()
        return host

    def update(self, instance, validated_data):
        """更新主机时处理密码"""
        password = validated_data.pop('password', None)
        if password:
            instance.set_password(password)
            instance.save()
        return super().update(instance, validated_data)

    class Meta:
        model = Host
        fields = '__all__'