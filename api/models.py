from django.db import models
from django.contrib.postgres.fields import ArrayField
from django.utils.safestring import mark_safe

class UserDetails(models.Model):
    userID = models.CharField(max_length=100,unique=True,null=False,blank=False)
    name = models.CharField(max_length=100,null=False,blank=False)
    ph_no = models.IntegerField(null=False,blank=False)
    address = models.CharField(max_length=100,null=False,blank=False)
    pincode = models.IntegerField(null=False,blank=False)
    state = models.CharField(max_length=100,null=False,blank=False)
    coins = models.IntegerField(default=0)
    profilepic = models.ImageField(upload_to='profilepics/',null=True,blank=True,default='profilepics/default.png')
    
class Posts(models.Model):
    userDetails = models.ForeignKey(UserDetails,on_delete=models.CASCADE)
    image = models.ImageField(upload_to='posts/',null=False,blank=False)
    description = models.TextField(null=False,blank=False)
    location = models.CharField(max_length=100,null=True,blank=True)
    comments = models.JSONField()
    likes = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    
    # comments = {
    #     'comments':[
    #         {
    #             "userID":"String",
    #             "comment":"String"
    #         }
    #         ]
    #     }
    
    # likes = {
    #       'likes':[
    #           {
    #               "userID":"String"
    #           }
    #       ]    
    # }
    
class Item(models.Model):
    name = models.CharField(max_length=100,null=False,blank=False)
    price = models.IntegerField(null=False,blank=False)
    description = models.TextField(null=False,blank=False)
    image = models.ImageField(upload_to='items/',null=True,blank=True)
    category = models.CharField(max_length=100,null=False,blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def item_photo(self):
        return mark_safe('<img src="{}" width="100" height="100" />'.format(self.image.url))
    
class Restaurants(models.Model):
    name = models.CharField(max_length=100,null=False,blank=False)
    address = models.TextField(null=False,blank=False)
    longitude = models.FloatField(null=False,blank=False)
    lattitude = models.FloatField(null=False,blank=False)
    