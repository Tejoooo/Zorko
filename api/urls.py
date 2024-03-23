from django.urls import path
from . import views


urlpatterns = [
    path('user/',views.UserView.as_view(),name='User View'),
    path('posts/',views.PostsView.as_view(),name='Posts View'),
    path('like/',views.LikeView.as_view(),name='Like View'),
    path('comment/',views.CommentView.as_view(),name='Comment View'),
]