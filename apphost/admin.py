from django.contrib import admin
from django import forms
# Register your models here.

from .models import City, MachineRoom, Host  # 导入你定义的模型

# 注册 City 模型
@admin.register(City)
class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'description')  # 列表页显示的字段
    search_fields = ('name', 'code')  # 可搜索的字段

# 注册 MachineRoom 模型
@admin.register(MachineRoom)
class MachineRoomAdmin(admin.ModelAdmin):
    list_display = ('name', 'city', 'address', 'contact')
    list_filter = ('city',)  # 侧边栏过滤字段
    search_fields = ('name', 'address')

class HostAdminForm(forms.ModelForm):
    password = forms.CharField(label='主机密码', widget=forms.PasswordInput, required=False)

    class Meta:
        model = Host
        fields = '__all__'

    def save(self, commit=True):
        host = super().save(commit=False)
        password = self.cleaned_data.get('password')
        if password:
            host.set_password(password)
        if commit:
            host.save()
        return host


# 注册 Host 模型
@admin.register(Host)
class HostAdmin(admin.ModelAdmin):
    form = HostAdminForm
    list_display = ('hostname', 'ip_address', 'machine_room', 'status', 'os')
    list_filter = ('machine_room', 'status')  # 侧边栏过滤字段
    search_fields = ('hostname', 'ip_address')