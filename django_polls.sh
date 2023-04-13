#!/bin/bash
sleep 5
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser --noinput
python manage.py collectstatic --no-input
python manage.py runserver 0.0.0.0:8080