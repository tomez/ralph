# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import ralph.lib.mixins.models


class Migration(migrations.Migration):

    dependencies = [
        ('virtual', '0011_cloudprovider_client_config'),
    ]

    operations = [
        migrations.CreateModel(
            name='CloudImage',
            fields=[
                ('id', models.AutoField(verbose_name='ID', primary_key=True, serialize=False, auto_created=True)),
                ('image_id', models.CharField(verbose_name='image ID', max_length=100, unique=True)),
                ('name', models.CharField(max_length=200)),
            ],
            bases=(ralph.lib.mixins.models.AdminAbsoluteUrlMixin, models.Model),
        ),
    ]
