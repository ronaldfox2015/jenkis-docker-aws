FROM jenkinsci/blueocean

USER root

RUN apk add --update make

RUN cat /etc/issue

RUN apk add --update py-pip

RUN pip install awscli 


RUN pip install awscli --upgrade --user

ENV APP_DIR=/app

RUN mkdir $APP_DIR

WORKDIR $APP_DIR
