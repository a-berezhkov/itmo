 
ARG NODE_VERSION=22.0.0

FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
ENV NODE_ENV production


WORKDIR /usr/src/app

RUN mkdir server
RUN mkdir client
 
COPY /server/package.json ./server
COPY /server/package-lock.json ./server
 
COPY ./server ./server

RUN cd server && npm i

COPY /client/package.json ./client
COPY /client/package-lock.json ./client
 
COPY ./client ./client

RUN cd client && npm i && npm run build

COPY ./client/dist ./server/public/dist

# Expose the port that the application listens on.
EXPOSE 80

# Run the application.
CMD ["server", "node app.js"]
