from django.shortcuts import render, redirect
from django.http import *
from .models import *
from django.contrib import messages
from authen.models import *
from .forms import *
import datetime
from django.urls import reverse
from django.core.mail import send_mail
from django.contrib import messages
from django.db.models import Count
import datetime, pytz
from datetime import datetime, timezone


def book(request, myid):
    user = request.user
    book = Books.objects.filter(id=myid).first()
    shelf_list = PShelf.objects.filter(username=user.username)
    loan_info = Loan.objects.filter(bid=myid).first()
    reviews = Reviews.objects.filter(isbn_number=book.isbn_number)
    books_isued = Loan.objects.filter(username=user.username)
    no_of_books = len(books_isued)
    is_invalid=0
    if user.is_faculty==0 and no_of_books>3 and user.unpaid_fines>1000:
        is_invalid=1
    ids = list()
    for item in shelf_list:
        ids.append(item.bid)
    return render(request, 'item.html', {'book': book, 'ids': ids, 'loan_info': loan_info, 'reviews': reviews, 'is_invalid':is_invalid})


def pshelf(request):
    user = request.user
    username = user.username
    shelf_list = PShelf.objects.filter(username=username)
    ids = list()
    for item in shelf_list:
        ids.append(item.bid)
    book = Books.objects.filter(id__in=ids)
    return render(request, 'pshelf.html', {'pshelf': shelf_list, 'book': book})


def create_pshelf(request, pid):
    user = request.user
    username = user.username
    wishlisted = PShelf.objects.filter(username=user.username).filter(bid=pid)
    if len(wishlisted) != 0:
        PShelf.objects.filter(username=user.username).filter(bid=pid).delete()
    else:
        shelf_list = PShelf(username=username, bid=pid)
        shelf_list.save()
    return redirect(request.META.get('HTTP_REFERER', 'redirect_if_referer_not_found'))


def library(request, category):
    user = request.user
    if category == "all":
        tempb = Books.objects.all().order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.all().order_by('isbn_number').filter(
            current_status='on-loan')
    elif category == "fiction":
        tempb = Books.objects.filter(category='Fiction').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Fiction').filter(current_status='on-loan')
    elif category == "science":
        tempb = Books.objects.filter(category='Science').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Science').filter(current_status='on-loan')
    elif category == "business":
        tempb = Books.objects.filter(category='Business').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Business').filter(current_status='on-loan')
    elif category == "biography":
        tempb = Books.objects.filter(category='Biography').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Biography').filter(current_status='on-loan')
    elif category == "literature":
        tempb = Books.objects.filter(category='Literature').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Literature').filter(current_status='on-loan')
    elif category == "others":
        tempb = Books.objects.filter(category='Others').order_by('isbn_number').filter(
            current_status='on-shelf') | Books.objects.order_by('isbn_number').filter(
            category='Others').filter(current_status='on-loan')
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
                curr_date = datetime.now(timezone.utc)
                loan_info = Loan.objects.all().filter(bid=tempb[x].id).first()
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

    reco1 = Books.objects.order_by('-id').filter(current_status='on-shelf')[:3]
    reco2 = Books.objects.order_by('-id').filter(current_status='on-shelf')[3:6]
    shelf_list = PShelf.objects.filter(username=user.username)
    ids = list()
    for item in shelf_list:
        ids.append(item.bid)
    return render(request, 'library.html', {'books': books, 'ids': ids, 'reco1': reco1, 'reco2': reco2})


def hold(request, myid):
    user = request.user
    if user is not None:
        if user.is_active:
            book = Books.objects.filter(id=myid).first()
            bookname = book.title
            isbn = book.isbn_number
            copy = book.copy_number
            hold_date = datetime.datetime.now()
            hold_limit = hold_date + datetime.timedelta(days=10)
            if user.is_faculty:
                holdr = Hold(username=user.username, bid=book.id, isbn_number=isbn, copy_number=copy, title=bookname,
                             hold_date=hold_date)
                holdr.save()
            else:
                holdr = Hold(username=user.username, bid=book.id, isbn_number=isbn, copy_number=copy, title=bookname,
                             hold_date=hold_date, hold_limit=hold_limit)
                holdr.save()
            if book.current_status == 'on-shelf':
                book.current_status = 'on-hold'
            elif book.current_status == 'on-loan':
                book.current_status = 'on-loan-and-on-hold'
            book.save()
            return redirect('/library/category/all')
            # return redirect('home')
        return redirect('login')


def booksonhold(request):
    user = request.user
    username = user.username
    hold = Hold.objects.filter(username=username)
    ids = list()
    for x in hold:
        ids.append(x.bid)
    books = Books.objects.filter(id__in=ids)
    return render(request, 'booksonhold.html', {'books': books, 'hold': hold})


def deletehold(request, bid):
    user = request.user
    username = user.username
    book = Books.objects.filter(id=bid).first()
    if book.current_status == 'on-loan-and-on-hold':
        book.current_status = 'on-loan'
    else:
        book.current_status = 'on-shelf'
    book.save()
    Hold.objects.filter(bid=bid).delete()
    return redirect(request.META.get('HTTP_REFERER', 'redirect_if_referer_not_found'))


def booksonloan(request):
    user = request.user
    username = user.username
    loan = Loan.objects.filter(username=username)
    ids = list()
    for x in loan:
        ids.append(x.bid)
    books = Books.objects.filter(id__in=ids)
    return render(request, 'booksonloan.html', {'books': books})


def review(request, bid):
    user = request.user
    if request.method == 'POST':
        form = Review(request.POST)
        if form.is_valid():
            book = Books.objects.filter(id=bid).first()
            rating = form.save()
            rating.username = user.username
            rating.isbn_number = book.isbn_number
            rating.save()
            r = '/library/book/' + str(bid)
            return redirect(r)
    else:
        form = Review()
        book = Books.objects.filter(id=bid).first()
        return render(request, 'review.html', {'form': form, 'book': book})


"""

def yourads(request):
    user = request.user
    username = user.username
    pro = Products.objects.filter(seller=username)
    requests = Requests.objects.filter(seller=username)
    count = Requests.objects.values('pid').annotate(pcount=Count('pid'))
    prolist = list()
    for x in count:
        if x['pcount'] > 0:
            prolist.append(x['pid'])
    return render(request, 'booksonloan.html', {'product': pro, 'requests': requests, 'prolist': prolist})


def deletead(request, pid):
    user = request.user
    username = user.username
    Products.objects.filter(id=pid).filter(seller=username).delete()
    return redirect(request.META.get('HTTP_REFERER', 'redirect_if_referer_not_found'))


def editad(request, pid):
    user = request.user
    if request.method == 'POST':
        editform = Edit_Item(request.POST)
        if editform.is_valid():
            item = Products.objects.filter(id=pid).first()
            item.name = editform.cleaned_data.get('name')
            item.description = editform.cleaned_data.get('description')
            item.sell = editform.cleaned_data.get('sell')
            item.price = editform.cleaned_data.get('price')
            item.category = editform.cleaned_data.get('category')
            item.save()
    else:
        pro = Products.objects.filter(id=pid).values().first()
        editform = Edit_Item(initial=pro)
        return render(request, 'editad.html', {'form': editform})
    return redirect('yourads')


def sell(request):
    user = request.user
    if request.method == 'POST':
        form = Item(request.POST, request.FILES)
        if form.is_valid():
            item = form.save()
            item.seller = user.username
            item.save()
            return redirect('sell')
    else:
        form = Item()
        return render(request, 'review.html', {'form': form})





def sendrequest(request, myid):
    user = request.user
    if user is not None:
        if user.is_active:
            pro = Products.objects.filter(id=myid).first()
            prodname = pro.name
            seller = pro.seller
            sellerinfo = CustomUser.objects.filter(username=seller).first()
            email = sellerinfo.email
            message = user.full_name + " has sent you a buy request for the product- " + prodname
            notif = "We have notified " + sellerinfo.full_name + " about your request for the product- " + prodname + " You can also contact him through his Phone Number: " + sellerinfo.phone_no
            send_mail("New buy request", message, 'honeycomb.iiti@gmail.com', [email])
            send_mail("Seller notified", notif, 'honeycomb.iiti@gmail.com', [user.email])
            requestp = Requests(pid=myid, buyer=user.username, seller=seller)
            requestp.save()
            return redirect('/buy/category/all')
            # return redirect('home')
        return redirect('login')


def confirm(request, pid):
    user = request.user
    if request.method == 'POST':
        seller = user.username
        buyer = request.POST['buyer']
        pro = Products.objects.filter(id=pid).first()
        pro.status = 1
        pro.save()
        transaction = Transaction(seller=seller, buyer=buyer, pid=pid, pname=pro.name)
        transaction.save()
        Requests.objects.filter(pid=pid).delete()
    return redirect(request.META.get('HTTP_REFERER', 'redirect_if_referer_not_found'))


def search(request):
    user = request.user
    if request.method == 'POST':
        search = request.POST['search']
        result = list()
        words = search.split()
        for x in words:
            result += Products.objects.filter(name__icontains=x) | Products.objects.filter(
                description__icontains=x) | Products.objects.filter(category__icontains=x).filter(status=0)
        wish_list = Wishlist.objects.filter(username=user.username)
        ids = list()
        reco1 = Products.objects.order_by('-id').filter(status=0)[:3]
        reco2 = Products.objects.order_by('-id').filter(status=0)[3:6]
        for item in wish_list:
            ids.append(item.pid)
        return render(request, 'search.html',
                      {'books': result, 'ids': ids, 'reco1': reco1, 'reco2': reco2, 'search': search})
    return render(request, 'search.html')"""
