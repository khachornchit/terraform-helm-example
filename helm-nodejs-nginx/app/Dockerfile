FROM node:14.15.0-alpine3.10

WORKDIR /usr/share/app

COPY package.json package.json
COPY node_modules node_modules
COPY app/server.js app/server.js
COPY app/controllers app/controllers
COPY app/models app/models

EXPOSE 3000

CMD ["npm", "run", "start:app"]
