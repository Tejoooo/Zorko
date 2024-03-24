from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from .models import UserDetails,Posts,Item,CartItem,Restaurants
from .serializers import UserDetailsSerializer,PostsSerializer,ItemSerializer,CartItemSerializer,PostSerializer,RestaurantSerializer
import json


class UserView(APIView):
    serializer_class = UserDetailsSerializer
    def get(self,request):
        userID = request.GET.get('userID')
        user = UserDetails.objects.filter(userID=userID).first()
        if not user:
            return Response(data={"error":"User Doesn't exist"},status=status.HTTP_404_NOT_FOUND)
        user_serializer = self.serializer_class(user)
        return Response(data=user_serializer.data,status=status.HTTP_200_OK)
    
    def post(self,request):
        user_serializer = self.serializer_class(data=request.data)
        if user_serializer.is_valid():
            user_serializer.save()
            return Response(data=user_serializer.data,status=status.HTTP_201_CREATED)
        return Response(data=user_serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
class PostsView(APIView):
    serializer_class = PostsSerializer
    def get(self,request):
        posts = Posts.objects.all().order_by('-id')
        post_serializer = self.serializer_class(posts, many=True)
        return Response(data=post_serializer.data, status=status.HTTP_200_OK)

    def post(self,request):
        userID = request.data.get('userID')
        if not userID:
            return Response({"error": "userID is required"}, status=status.HTTP_400_BAD_REQUEST)
        userDetails = UserDetails.objects.get(userID=userID)
        requestData = request.data
        requestData['userDetails'] = userDetails.id
        post_serializer = PostSerializer(data=requestData)
        if post_serializer.is_valid():
            post_serializer.save()
            return Response(data=post_serializer.data,status=status.HTTP_201_CREATED)
        print(post_serializer.errors)
        return Response(data=post_serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
class LikeView(APIView):
    def post(self,request):
        postID = request.data.get('postID')
        post = Posts.objects.get(id=postID)
        value = request.data.get('value')
        userID = request.data.get('userID')
        likes = post.likes
        if int(value) == -1:
            likes['likes'].remove({'userID': userID})
            post.save()
            return Response(data={"message":"Post Unliked"},status=status.HTTP_200_OK)
        if any(like['userID'] == userID for like in likes['likes']):
            return Response(data={"message": "User already liked the post"}, status=status.HTTP_202_ACCEPTED)
        likes['likes'].append({'userID': request.data.get('userID')})
        post.save()
        return Response(data={"message":"Post Liked"},status=status.HTTP_201_CREATED)
    
class CommentView(APIView):
    def post(self,request):
        postID = request.data.get('postID')
        post = Posts.objects.get(id=postID)
        comment = request.data.get('comment')
        userID = request.data.get('userID')
        comments = post.comments
        comments['comments'].append({'userID': userID, 'comment': comment})
        post.save()
        return Response(data={"message":"Comment Added"},status=status.HTTP_201_CREATED)

class AddtoCartView(APIView):
    def post(self,request):
        userID = request.data.get('userID')
        itemID = request.data.get('itemID')
        user = UserDetails.objects.filter(userID=userID).first()
        item = Item.objects.filter(id=int(itemID)).first()
        cartItem = CartItem.objects.filter(user=user,item=item).first()
        if cartItem:
            cartItem.quantity += 1
            cartItem.save()
            return Response(data={"message":"Item added to cart"},status=status.HTTP_200_OK)
        else:
            user = UserDetails.objects.get(userID=userID)
            item = Item.objects.get(id=itemID)
            cartItem = CartItem.objects.create(user=user,item=item)
            return Response(data={"message":"Item added to cart"},status=status.HTTP_201_CREATED)
        
class DeleteFromCartView(APIView):
    def post(self,request):
        itemID = int(request.data.get('itemID'))
        userID = request.data.get('userID')
        user = UserDetails.objects.filter(userID=userID).first()
        item = Item.objects.filter(id=int(itemID)).first()
        cartItem = CartItem.objects.filter(user=user,item=item).first()
        if cartItem:
            if cartItem.quantity == 1:
                cartItem.delete()
                return Response(data={"message":"Item removed from cart"},status=status.HTTP_200_OK)
            cartItem.quantity -= 1
            cartItem.save()
            return Response(data={"message":"Item removed from cart"},status=status.HTTP_200_OK)
        return Response(data={"message":"Item not in cart"},status=status.HTTP_404_NOT_FOUND)
    
class CartView(APIView):
    serializer_class = CartItemSerializer
    def post(self,request):
        userID = request.data.get('userID')
        user = UserDetails.objects.filter(userID=userID).first()
        cartItems = CartItem.objects.filter(user=user)
        if cartItems:
            serializer_data = self.serializer_class(cartItems,many=True)
            return Response(data=serializer_data.data,status=status.HTTP_200_OK)
        return Response(data={"message":"Cart is empty"},status=status.HTTP_404_NOT_FOUND)
    
class HomeItemsView(APIView):
    serializer_class = ItemSerializer
    def get(self,request):
        items = Item.objects.all()
        categories = Item.objects.values_list('category',flat=True).distinct()
        serialized_data = []
        for category in categories:
            items_in_category = items.filter(category=category)[:5]
            serialized_items = self.serializer_class(items_in_category, many=True).data
            serialized_data.append(serialized_items)
        return Response(data=serialized_data, status=status.HTTP_200_OK)
    
class Outlets(APIView):
    def get(self,request):
        allObjects = Restaurants.objects.all()
        serializer_data = RestaurantSerializer(allObjects,many=True)
        return Response(data=serializer_data.data,status=status.HTTP_200_OK)
    
class MenuView(APIView):
    def get(self,requst):
        allObjects = Item.objects.all()
        serialzer_data = ItemSerializer(allObjects,many=True)
        return Response(data=serialzer_data.data,status=status.HTTP_200_OK)
    
class OrderView(APIView):
    def post(self,request):
        userID = request.data.get('userID')
        user = UserDetails.objects.filter(userID=userID).first()
        cartItems = CartItem.objects.filter(user=user)
        if not cartItems:
            return Response(data={"message":"Cart is empty"},status=status.HTTP_404_NOT_FOUND)
        total = 0
        for cartItem in cartItems:
            total += cartItem.item.price * cartItem.quantity
        user.coins += total*0.1
        user.save()
        cartItems.delete()
        return Response(data={"total":total},status=status.HTTP_200_OK)