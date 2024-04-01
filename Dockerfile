FROM nginx:latest

RUN mkdir -p /usr/shared/nginx/html/images
RUN mkdir -p /usr/shared/nginx/html/style

COPY ./images /usr/share/nginx/html/images
COPY ./style /usr/share/nginx/html/style
COPY ./index.html /usr/share/nginx/html/

EXPOSE 80