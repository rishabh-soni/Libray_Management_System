from django.shortcuts import render, redirect
from django.http import *
from django.contrib import messages
from django.contrib.auth import authenticate, login
from books.models import *
from .forms import *
import datetime
from books.models import PShelf
from django.core.mail import send_mail
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.template import RequestContext
from django_email_verification import sendConfirm
from django.contrib.auth import get_user_model


def home(request):
    user = request.user
    tempb = Books.objects.order_by('-id').order_by('isbn_number').filter(current_status='on-shelf')[:8]
    books = list()
    x = 0
    while x < len(tempb):
        current_isbn = tempb[x].isbn_number
        flag = 0
        while tempb[x].isbn_number == current_isbn:
            if tempb[x].current_status == 'on-shelf' and flag == 0:
                books.append(tempb[x])
                flag = 1
            elif tempb[x].current_status == 'on-loan' and flag == 0:
                curr_date = datetime.datetime.now()
                loan_info = Loan.objects.all().filter(tempb[x].bid).first()
                ret_date = loan_info.return_date
                dt = ret_date - curr_date
                if user.is_faculty:
                    flag = 1
                    books.append(tempb[x])
                else:
                    if dt.days <= 10:
                        flag = 1
                        books.append(tempb[x])
            x += 1
            if x == len(tempb):
                break

    friends_info = Friends.objects.filter(id1=user.id).values('id2')
    username_info = CustomUser.objects.filter(id__in=friends_info).values('username')
    wishlist_info =PShelf.objects.filter(username__in=username_info).values('bid')
    tempb = Books.objects.filter(id__in=wishlist_info).order_by('isbn_number')
    books1=list()
    x = 0
    while x < len(tempb):
        current_isbn = tempb[x].isbn_number
        flag = 0
        while tempb[x].isbn_number == current_isbn:
            if tempb[x].current_status == 'on-shelf' and flag == 0:
                books1.append(tempb[x])
                flag = 1
            elif tempb[x].current_status == 'on-loan' and flag == 0:
                curr_date = datetime.now(timezone.utc)
                loan_info = Loan.objects.all().filter(bid=tempb[x].id).first()
                ret_date = loan_info.return_date
                dt = ret_date - curr_date
                if user.is_faculty:
                    flag = 1
                    books1.append(tempb[x])
                else:
                    if dt.days <= 10:
                        flag = 1
                        books1.append(tempb[x])
            x += 1
            if x == len(tempb):
                break
    shelf_list = PShelf.objects.filter(username=user.username)
    ids = list()
    reco1 = books1[:8]
    for item in shelf_list:
        ids.append(item.bid)
    return render(request, 'auth/home.html', {'books': books, 'ids': ids, 'reco1':reco1})


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


def following(request):
    user = request.user
    if user is not None:
        if user.is_active:
            following_id = Friends.objects.filter(id1=user.id)
            following_info = list()
            for x in following_id:
                following_info += CustomUser.objects.filter(id=x.id2)
            return render(request, 'friends.html', {'following': following_info})
        return redirect('login')


def unfollow(request, id):
    user = request.user
    if user is not None:
        if user.is_active:
            Friends.objects.filter(id2=id).delete()
            return redirect('following')
        return redirect('login')


def follow(request, id):
    user = request.user
    if user is not None:
        if user.is_active:
            record = Friends(id1=user.id, id2=id)
            record.save()
            return redirect('following')
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


def resend(request, username):
    user = CustomUser.objects.get(username=username)
    sendConfirm(user)
    return render(request, 'link_sent.html', {'username': user.username})


def rules(request):
    user = request.user
    return render(request, 'rules.html')


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


def handler404(request, *args, **argv):
    response = render(request, '404.html')
    response.status_code = 404
    return response


def error(request):
    response = render(request, '404.html')
    return response
