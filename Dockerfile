# Stage I
FROM node:12.2.0-alpine AS build

# set working directory
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage II
FROM nginx:1.17.10-alpine

COPY --from=build /app/dist/ /usr/share/nginx/html

COPY /nginx-custom.conf /etc/nginx/conf.d/default.conf