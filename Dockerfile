FROM node:boron

RUN node --version
RUN npm --version
RUN apt-get update && apt-get install -y build-essential && apt-get -y install sudo

# Install app dependencies
COPY package.json /usr/src/app/

RUN npm install

EXPOSE 8080
CMD [ "npm", "dev" ]
