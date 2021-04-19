# Generated by Django 3.1.2 on 2021-04-18 12:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('books', '0002_books_category'),
    ]

    operations = [
        migrations.CreateModel(
            name='Hold',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=150)),
                ('bid', models.IntegerField()),
                ('isbn_number', models.CharField(max_length=45)),
                ('copy_number', models.IntegerField()),
                ('title', models.CharField(max_length=255)),
                ('hold_date', models.DateTimeField()),
                ('hold_limit', models.DateTimeField(null=True)),
            ],
        ),
    ]
