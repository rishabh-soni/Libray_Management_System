from django.contrib import admin
from .models import Books, Shelf, Hold


class BooksAdmin(admin.ModelAdmin):
    list_display = ('title', 'copy_number', 'author')


class ShelfAdmin(admin.ModelAdmin):
    list_display = ('shelf_id', 'capacity')


class HoldAdmin(admin.ModelAdmin):
    list_display = ('title', 'copy_number', 'username', 'hold_date')


admin.site.register(Books, BooksAdmin)
admin.site.register(Shelf, ShelfAdmin)
admin.site.register(Hold, HoldAdmin)