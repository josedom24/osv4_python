FROM registry.access.redhat.com/ubi8/python-39:latest

# Copiar la aplicación y los archivos de configuración al contenedor
WORKDIR /tmp/app
COPY app /tmp/app 
ADD ./django_polls.sh /tmp/app/django_polls.sh
RUN chmod +x /tmp/app/django_polls.sh

# Instalar los requisitos de la aplicación
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt

# Crear el directorio "static"
RUN mkdir static

# Definir las variables de entorno
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org

# Especificar el comando de entrada
ENTRYPOINT ["/tmp/app/django_polls.sh"]
