FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html
RUN echo '<h1>Hello from NGINX!</h1>' > /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]