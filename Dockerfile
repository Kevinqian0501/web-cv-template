FROM ubuntu:latest

# Update python, Install virtualenv, nginx, supervisor
RUN apt-get update --fix-missing  \ 
    && apt-get install -y build-essential git \
    && apt-get install -y python python-dev python-setuptools \
    && apt-get install -y python-pip python-virtualenv \
    && apt-get install -y nginx supervisor

RUN service supervisor stop \
    && service nginx stop

ADD ./requirements.txt ./
RUN pip install -r requirements.txt

# expose port
EXPOSE 8080 9001

RUN pip install supervisor-stdout


# Add our config files
ADD ./supervisor.conf /etc/supervisor.conf
ADD ./nginx.conf /etc/nginx/nginx.conf


# start supervisor to run our wsgi server, nginx, supervisor-stdout
CMD supervisord -c /etc/supervisor.conf -n

