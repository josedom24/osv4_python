#!/bin/bash
sleep 5
python manage.py createsuperuser --noinput
python manage.py runserver 0.0.0.0:8080