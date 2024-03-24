from django.urls import path
from . import views


urlpatterns = [
    path('user/',views.UserView.as_view(),name='User View'),
    path('posts/',views.PostsView.as_view(),name='Posts View'),
    path('like/',views.LikeView.as_view(),name='Like View'),
    path('comment/',views.CommentView.as_view(),name='Comment View'),
    path('add_to_cart/',views.AddtoCartView.as_view(),name='Add to Cart View'),
    path('delete_from_cart/',views.DeleteFromCartView.as_view(),name='Delete from Cart View'),
    path('cart/',views.CartView.as_view(),name='Cart View'),
    path('home_items/',views.HomeItemsView.as_view(),name='Home Items View'),
    path('outlets/',views.Outlets.as_view(),name='Outlets'),
    path('menu/',views.MenuView.as_view(),name='Menu View'),
    path('order/',views.OrderView.as_view(),name='Order View'),
    path('redeem/',views.RedeemView.as_view(),name='Redeem View'),
]