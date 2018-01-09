FROM node:8

RUN node --version
RUN npm --version
RUN apt-get update && apt-get install -y build-essential && apt-get -y install sudo

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/

# Bundle app source
COPY . /usr/src/app

RUN npm install

EXPOSE 8080
CMD npm run dev
