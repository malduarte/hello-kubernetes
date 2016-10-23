FROM node:4.4
EXPOSE 6969
COPY server.js .
CMD node server.js

