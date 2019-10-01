# dock-tutorials
官网学习docker过程中的一些命令，代码，和示例
COUCH1=$(docker run -d -p 5984 -v /var/lib/couchdb couchdb)
HOST=192.168.1.102
URL="http://$HOST:$(docker port $COUCH1 5984 | grep -o '[1-9][0-9]*$')/utils/"
echo "Navigate to $URL in your browser, and use the couch interface to add data"


COUCH2=$(docker run -d -p 5984 --volumes-from $COUCH1 couchdb)
HOST=192.168.1.102
URL2="http://$HOST:$(docker port $COUCH2 5984 | grep -o '[1-9][0-9]*$')/_utils/"
echo "Navigate to $URL2 in your browser. You should see the same data as in the first database"'!'


docker rm $(docker ps -aq)


Dockerfile

FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/


requiemments.txt
Django>=2.0,<3.0
psycopg2>=2.7,<3.0


docker-compose.yml


version: '3'

services:
  db:
    image: postgres
  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db

sudo docker-compose run web django-admin startproject composeexample .
sudo chown -R $USER:$USER .



composeexample/settings.python


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}

 docker-compose up

docker-compose down


sshd


dockerfile
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

 docker build -t eg_sshd .


$ docker run -d -P --name test_sshd eg_sshd
$ docker port test_sshd 22

0.0.0.0:49154



$ ssh root@192.168.1.2 -p 49154
# or
$ ssh root@localhost -p 49154
