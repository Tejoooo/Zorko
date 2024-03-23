from rest_framework import serializers
from .models import UserDetails,Posts,Item

class UserDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetails
        fields = '__all__'
        
class PostsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Posts
        fields = '__all__'
        
class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = '__all__'