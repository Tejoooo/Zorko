from rest_framework import serializers
from .models import UserDetails,Posts,Item

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
        
class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = '__all__'