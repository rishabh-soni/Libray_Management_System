# Generated by Django 3.1.2 on 2021-04-17 19:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authen', '0003_auto_20210417_2030'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='address',
            field=models.CharField(blank=True, max_length=300, null=True),
        ),
    ]