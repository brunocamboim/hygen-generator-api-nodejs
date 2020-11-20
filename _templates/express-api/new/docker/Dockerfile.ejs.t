---
to: ../<%= folderName %>/docker/Dockerfile
---
FROM node:12-alpine

RUN apk add git --no-cache

WORKDIR /api

RUN npm i -g dotenv-cli