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

EXPOSE 8080
