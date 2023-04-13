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
COPY django_polls.sh /app/django_polls.sh
RUN chmod +x django_polls.sh
RUN chown -R appuser:appgroup /app
RUN python manage.py makemigrations
RUN python manage.py migrate
RUN python manage.py createsuperuser --noinput
RUN python manage.py collectstatic --no-input


ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
ENTRYPOINT ["/app/django_polls.sh"]