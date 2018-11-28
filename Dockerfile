# Alpine linux with Java
FROM maven:3.6.0-jdk-8-alpine

RUN apk update && apk upgrade

# Install robot dependencies
RUN apk add --update py2-pip
RUN pip install --upgrade pip
RUN pip install --upgrade selenium
RUN pip install --upgrade robotframework
RUN pip install --upgrade robotframework-seleniumlibrary
RUN pip install --upgrade robotframework-selenium2library

# Install chrome dependencies
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk add firefox jq curl
RUN rm -rf /var/cache/apk/*

COPY geckodriver.sh geckodriver.sh
RUN sh geckodriver.sh

EXPOSE 8080
