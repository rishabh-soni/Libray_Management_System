from django.shortcuts import render, redirect
from django.http import *
from django.contrib import messages
from django.contrib.auth import authenticate, login
from books.models import Books
from .forms import *
from books.models import PShelf
from django.core.mail import send_mail
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.template import RequestContext
from django_email_verification import sendConfirm
from django.contrib.auth import get_user_model


def home(request):
    user = request.user
    books = Books.objects.order_by('-id').filter(current_status='on-shelf')[:8]
    shelf_list = PShelf.objects.filter(username=user.username)
    ids = list()
    #reco1 = Books.objects.order_by('-id').filter(current_status='on_shelf')[:3]
    #reco2 = Books.objects.order_by('-id').filter(current_status='on_shelf')[3:6]
    for item in shelf_list:
        ids.append(item.bid)
    return render(request, 'auth/home.html', {'books': books, 'ids': ids})


"""def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            sendConfirm(user)
            return render(request, 'link_sent.html', {'username': user.username})
    else:
        form = SignUpForm()
    return render(request, 'auth/signup.html', {'form': form})"""


def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            user.save()
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=user.username, password=raw_password)
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return redirect('home')
    else:
        form = SignUpForm()
    return render(request, 'auth/signup.html', {'form': form})


def profile(request):
    user = request.user
    if user is not None:
        if user.is_active:
            passform = PasswordChangeForm(request.user)
            profileform = EditForm()
            return render(request, 'profile.html', {'profileform': profileform, 'passform': passform})
        return redirect('login')


def editprofile(request):
    user = request.user
    if request.method == 'POST':
        form = EditForm(request.POST)
        if form.is_valid():
            user.email = form.cleaned_data.get("email")
            user.full_name = form.cleaned_data.get("full_name")
            user.phone_no = form.cleaned_data.get("phone_no")
            user.address = form.cleaned_data.get("address")
            user.save()
            passform = PasswordChangeForm(request.user)
            profileform = EditForm()
            messages.info(request, 'Your profile has been changed successfully!')
            return render(request, 'profile.html', {'profileform': profileform, 'passform': passform})
        else:
            passform = PasswordChangeForm(request.user)
            profileform = EditForm()
            messages.info(request, 'Check for any errors and try again.')
            return render(request, 'profile.html', {'profileform': profileform, 'passform': passform})
    return redirect('profile')


def editpassword(request):
    if request.method == 'POST':
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)
            passform = PasswordChangeForm(request.user)
            profileform = EditForm()
            messages.info(request, 'Password has been changed successfully!')
            return render(request, 'profile.html', {'profileform': profileform, 'passform': passform})
        else:
            passform = PasswordChangeForm(request.user)
            profileform = EditForm()
            messages.info(request, 'Check for any errors and try again.')
            return render(request, 'profile.html', {'profileform': profileform, 'passform': passform})
    return redirect('profile')

"""
def resend(request, username):
    user = CustomUser.objects.get(username=username)
    sendConfirm(user)
    return render(request, 'link_sent.html', {'username': user.username})


def aboutus(request):
    user = request.user
    return render(request, 'aboutus.html')


def contactus(request):
    user = request.user
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            name = form.cleaned_data.get("name")
            email = form.cleaned_data.get("email")
            message = form.cleaned_data.get("message")
            subject = form.cleaned_data.get("subject")
            message = name + " with the email, " + email + ", sent the following message:\n\n" + message
            send_mail(subject, message, 'honeycomb.iiti@gmail.com', ['honeycomb.iiti@gmail.com'])
            return redirect('contactus')
        else:
            form = ContactForm()
            return redirect('home')
    else:
        form = ContactForm()
        return render(request, 'contact-us.html', {'form': form})
"""

def handler404(request, *args, **argv):
    response = render(request, '404.html')
    response.status_code = 404
    return response


def error(request):
    response = render(request, '404.html')
    return response
