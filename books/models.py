from django.db import models
from django import forms
from authen.models import CustomUser

STATUS_CHOICES = [
    ('on-loan', 'on-loan'),
    ('on-shelf', 'on-shelf'),
    ('on-hold', 'on-hold'),
    ('on-loan-and-on-hold', 'on-loan-and-on-hold'),
]

CATEGORY_CHOICES = [
    ('Fiction', 'Fiction'),
    ('Science', 'Science'),
    ('Business', 'Business'),
    ('Biography', 'Biography'),
    ('Literature', 'Literature'),
    ('Others', 'Others'),
]

RATING_CHOICES = [
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
]


class Shelf(models.Model):
    shelf_id = models.IntegerField(primary_key=True)
    capacity = models.IntegerField()


class Books(models.Model):
    isbn_number = models.CharField(max_length=45)
    copy_number = models.IntegerField()
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    year_of_publication = models.IntegerField()
    shelf_id = models.ForeignKey(Shelf, on_delete=models.CASCADE)
    current_status = models.CharField(max_length=255, choices=STATUS_CHOICES)
    category = models.CharField(max_length=255, choices=CATEGORY_CHOICES, default='Others')
    Img1 = models.ImageField(upload_to='images/', default='images/no-image.jpg')

    class Meta:
        unique_together = (('isbn_number', 'copy_number'),)


class PShelf(models.Model):
    username = models.CharField(max_length=150)
    bid = models.IntegerField()


class Hold(models.Model):
    username = models.CharField(max_length=150)
    bid = models.IntegerField()
    isbn_number = models.CharField(max_length=45)
    copy_number = models.IntegerField()
    title = models.CharField(max_length=255)
    hold_date = models.DateTimeField()
    hold_limit = models.DateTimeField(null=True)


class Loan(models.Model):
    username = models.CharField(max_length=150)
    bid = models.IntegerField()
    isbn_number = models.CharField(max_length=45)
    copy_number = models.IntegerField()
    title = models.CharField(max_length=255)
    issue_date = models.DateField()
    return_date = models.DateField(null=True)
    last_rem_date = models.DateField(null=True)


class Reviews(models.Model):
    username = models.CharField(max_length=150)
    isbn_number = models.CharField(max_length=45)
    rating = models.IntegerField(default=5, choices=RATING_CHOICES)
    review = models.TextField(max_length=300, null=True)


"""
class Transaction(models.Model):
    buyer = models.CharField(max_length=255)
    seller = models.CharField(max_length=255)
    pid = models.IntegerField()
    pname = models.CharField(max_length=255)"""
