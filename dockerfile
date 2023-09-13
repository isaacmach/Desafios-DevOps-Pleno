FROM node:latest as angular
WORKDIR /app
COPY package.jason /app/
RUN npm install --silent 
COPY . .
RUN npm run build
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=angular app/dist/requests-http /usr/share/nginx/html
COPY ./config/nginx.config /etc/nginx/conf.d/default.conf

