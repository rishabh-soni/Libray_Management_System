# Generated by Django 3.1.2 on 2021-04-19 21:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('books', '0008_auto_20210420_0004'),
    ]

    operations = [
        migrations.AlterField(
            model_name='loan',
            name='issue_date',
            field=models.DateTimeField(),
        ),
        migrations.AlterField(
            model_name='loan',
            name='last_rem_date',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='loan',
            name='return_date',
            field=models.DateTimeField(null=True),
        ),
    ]
