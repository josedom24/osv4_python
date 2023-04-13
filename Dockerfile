FROM registry.access.redhat.com/ubi8/python-39:latest

# Crear un grupo y usuario, y cambiar el propietario de /usr/src/app
RUN groupadd -r mygroup && useradd -r -g mygroup myuser
RUN chown -R myuser:mygroup /usr/src/app

# Cambiar al usuario myuser
USER myuser

# Copiar la aplicación y los archivos de configuración al contenedor
WORKDIR /usr/src/app
COPY app /usr/src/app 
ADD ./django_polls.sh /usr/src/app/django_polls.sh
RUN chmod +x /usr/src/app/django_polls.sh

# Instalar los requisitos de la aplicación
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt

# Otorgar permisos de escritura y ejecución para /usr/src/app
RUN chmod -R ugo+wx /usr/src/app

# Crear el directorio "static"
RUN mkdir static

# Definir las variables de entorno
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org

# Especificar el comando de entrada
ENTRYPOINT ["/usr/src/app/django_polls.sh"]
