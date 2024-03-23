from django.contrib import admin
from .models import UserDetails,Posts,Item,Restaurants,CartItem
# Register your models here.

admin.site.register(Posts)

class UserDetailsAdmin(admin.ModelAdmin):
    list_display = ("userID","name","ph_no")
    search_fields = ('userID','name')


admin.site.register(UserDetails,UserDetailsAdmin)

class ItemsCustom(admin.ModelAdmin):
    list_display = ("name",'price','item_photo',"category")
    search_fields = ("name","price","category")
    
admin.site.register(Item,ItemsCustom)

class RestaurantsCustom(admin.ModelAdmin):
    list_display = ("name","address","longitude","lattitude")
    search_fields = ("name","address","longitude","lattitude")
    
admin.site.register(Restaurants,RestaurantsCustom)
admin.site.register(CartItem)