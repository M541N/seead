from django.urls import path
from api.views.auth_views import (
    SignupView,
    LoginView,
    TokenRefreshView,
    LogoutView,
    UserInfoView,
)

urlpatterns = [
    path("signup/", SignupView.as_view(), name="signup"),
    path("login/", LoginView.as_view(), name="login"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("logout/", LogoutView.as_view(), name="logout"),
    path("me/", UserInfoView.as_view(), name="user_info"),
]
