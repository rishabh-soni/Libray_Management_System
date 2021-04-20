from django.db import models
from django.contrib.auth.models import AbstractUser


class CustomUser(AbstractUser):
    full_name = models.CharField(max_length=100, blank=False)
    phone_no = models.CharField(max_length=100, blank=False)
    address = models.CharField(max_length=300, blank=True, null=True)
    unpaid_fines = models.IntegerField(default=0)
    is_faculty = models.BooleanField(default=0)
    books_withdrawn = models.IntegerField(default=0)


class Friends(models.Model):
    id1 = models.IntegerField()
    id2 = models.IntegerField()