# Generated by Django 3.1.3 on 2022-03-21 19:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('DataBase', '0010_remove_project_currency_type'),
    ]

    operations = [
        migrations.AlterField(
            model_name='param',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='project',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='user',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
    ]