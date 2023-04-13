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
ADD ./django_polls.sh /app/django_polls.sh
RUN chmod +x /app/django_polls.sh
RUN chown -R appuser:appgroup /app

ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org



RUN python manage.py migrate
RUN python manage.py collectstatic --no-input
# Crear el directorio de datos
RUN mkdir /data

# Establecer los permisos del directorio de datos
RUN chown -R appuser:appgroup /data
RUN chmod 775 /data

# Mover la base de datos al directorio de datos
RUN mv /app/db.sqlite3 /data/

# Establecer los permisos adecuados en la base de datos
RUN chown appuser:appgroup /data/db.sqlite3
RUN chmod 664 /data/db.sqlite3

# Actualizar la ubicación de la base de datos en la configuración de Django
ENV DATABASE_URL=sqlite:////data/db.sqlite3
USER 1001
CMD ["/app/django_polls.sh"]