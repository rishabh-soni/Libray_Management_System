from django import forms
from django.forms import ModelForm, Textarea
from .models import *
from django.utils.translation import gettext_lazy as _

RATING_CHOICES = [
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
]


class Review(forms.ModelForm):

    rating = forms.ChoiceField(choices=RATING_CHOICES)
    review = forms.Textarea

    class Meta:
        model = Reviews
        fields = ['rating', 'review']
        labels = {
            'rating': _('Rate the Book'),
            'review': _('Write a Review'),
        }


"""SELL_CHOICES = [
    ('sell', 'Sell'),
    ('rent_monthly', 'Rent Monthly'),
    ('rent_weekly', 'Rent Weekly'),
]


class Item(forms.ModelForm):
    description = forms.Textarea
    price = models.FloatField()
    category = forms.CharField(max_length=255, widget=forms.Select(choices=CATEGORY_CHOICES), )
    status = models.IntegerField(default=0)
    sell = forms.ChoiceField(choices=SELL_CHOICES)
    Img1 = models.ImageField(upload_to='images/', default='images/no-image.jpg')
    Img2 = models.ImageField(upload_to='images/', default='images/no-image.jpg')
    Img3 = models.ImageField(upload_to='images/', default='images/no-image.jpg')

    class Meta:
        model = Products
        fields = ['name', 'description', 'sell', 'price', 'category', 'Img1', 'Img2', 'Img3']
        labels = {
            'name': _('Product Title'),
            'description': _('Product Description'),
            'price': _('Selling/Rental Price'),
            'category': _('Product Category'),
            'Img1': _('Upload Image 1'),
            'Img2': _('Upload Image 2 (Optional)'),
            'Img3': _('Upload Image 3 (Optional)'),
            'sell': _('Sell or Rent'),
        }
        widgets = {

        }


class Edit_Item(forms.ModelForm):
    name = forms.CharField(max_length=255, widget=forms.TextInput(attrs={'readonly':'readonly'}))
    description = forms.Textarea
    price = models.FloatField()
    category = forms.CharField(max_length=255, widget=forms.Select(choices=CATEGORY_CHOICES), )
    status = models.IntegerField(default=0)
    sell = forms.ChoiceField(choices=SELL_CHOICES)

    class Meta:
        model = Products
        fields = ['name', 'description', 'sell', 'price', 'category']
        labels = {
            'name': _('Edit Name'),
            'description': _('Edit Description'),
            'price': _('Selling/Rental Price'),
            'category': _('Change Category'),
            'sell': _('Sell or Rent'),
        }
        widgets = {

        }"""

