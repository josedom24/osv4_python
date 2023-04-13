FROM bitnami/python:3.9

# Agregar estos comandos
USER root
RUN groupadd -g 1001 appgroup
RUN useradd -u 1001 -g 1001 -ms /bin/bash appuser

WORKDIR /app
COPY app /app
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt
RUN mkdir static
RUN chown -R appuser:appgroup /app

ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org

RUN python manage.py migrate
RUN python manage.py createsuperuser --noinput
RUN python manage.py collectstatic --no-input


CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000"]