FROM registry.access.redhat.com/ubi8/python-39:latest
WORKDIR /usr/src/app
COPY app /usr/src/app 
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt
RUN mkdir static
ADD ./django_polls.sh /usr/src/app/django_polls.sh
#RUN sudo chmod +x /usr/src/app/django_polls.sh
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
ENTRYPOINT ["/usr/src/app/django_polls.sh"]