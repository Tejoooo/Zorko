from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from .models import UserDetails,Posts
from .serializers import UserDetailsSerializer,PostsSerializer


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
        post_serializer = PostsSerializer(data=requestData,context={'userDetails':userDetails})
        if post_serializer.is_valid():
            post_serializer.save()
            return Response(data=post_serializer.data,status=status.HTTP_201_CREATED)
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