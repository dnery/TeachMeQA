# Alpine linux with Java
FROM maven:3.6.0-jdk-8-alpine

# Update package ecosystem
RUN apt-get update && apt-get upgrade && apt-get dist-upgrade

# Install robot dependencies
RUN apk add --update py2-pip
RUN pip install --upgrade pip
RUN pip install --upgrade robotframework

EXPOSE 8080
