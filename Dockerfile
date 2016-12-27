FROM node:argon
MAINTAINER Jesús García Manday "jmanday@gmail.com"

# Update argon
RUN apt-get update

# Install git
RUN apt-get install git

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Download the source project
RUN git clone https://github.com/jmanday/MEAN.git

# Install app dependencies
RUN cp -r ./MEAN/Proyecto2/* /usr/src/app/
RUN rm -rf ./MEAN
RUN npm install

# Bundle app source
#COPY . /usr/src/app

EXPOSE 3000
CMD [ "npm", "start" ]