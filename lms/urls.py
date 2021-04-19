"""lms URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URL conf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views
from authen import views
from django_email_verification import urls as mail_urls
from books import views as bookviews

urlpatterns = [
                  path('admin/', admin.site.urls),
                  path('', views.home, name='home'),
                  path('login/', auth_views.LoginView.as_view(template_name='auth/login.html'), name='login'),
                  path('logout/', auth_views.LogoutView.as_view(), name='logout'),
                  path('signup/', views.signup, name='signup'),
                  path('admin/', views.signup, name='admin'),
                  path('library/book/<int:myid>', bookviews.book, name='item'),
                  path('pshelf/', bookviews.pshelf, name='pshelf'),
                  path('pshelf/<int:pid>', bookviews.create_pshelf),
                  path('library/hold/<int:myid>', bookviews.hold, name='hold'),
                  # path('buy/search/', prodviews.search, name='search'),
                  path('library/category/<slug:category>', bookviews.library, name='library'),
                  # path('buy/confirm/<int:pid>', prodviews.confirm, name='confirm'),
                  path('booksonhold/', bookviews.booksonhold, name='booksonhold'),
                  path('deletehold/<int:bid>', bookviews.deletehold),
                  path('booksonloan/', bookviews.booksonloan, name='booksonloan'),
                  # path('yourads/', prodviews.yourads, name='yourads'),
                  # path('yourads/<int:pid>', prodviews.deletead),
                  # path('yourads/edit/<int:pid>', prodviews.editad),
                  path('profile/', views.profile, name='profile'),
                  path('profile/edit/general', views.editprofile, name='editprofile'),
                  path('profile/edit/password', views.editpassword, name='editpassword'),
                  path('review/<int:bid>', bookviews.review),
                  # path('contact-us/', views.contactus, name='contactus'),
                  path('404/', views.error, name='404'),
                  # path('email/', include(mail_urls)),
                  # path('resend/<slug:username>', views.resend, name='resend'),

              ] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)

# handler404 = views.handler404
