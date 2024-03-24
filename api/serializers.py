from rest_framework import serializers
from .models import UserDetails,Posts,Item,CartItem,Restaurants

class UserDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetails
        fields = '__all__'
        
        
class UserDetailsSerializerForPost(serializers.ModelSerializer):
    class Meta:
        model = UserDetails
        fields = ['id','name','profilepic']

class PostsSerializer(serializers.ModelSerializer):
    userDetails = UserDetailsSerializerForPost()
    class Meta:
        model = Posts
        fields = '__all__'
        
class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Posts
        fields = '__all__'
        
class PostSerializerForUploading(serializers.ModelSerializer):
    class Meta:
        model = Posts
        fields = "__all__"        

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = '__all__'
        
class CartItemSerializer(serializers.ModelSerializer):
    item = ItemSerializer()
    class Meta:
        model = CartItem
        fields = '__all__'
        
class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurants
        fields = '__all__'