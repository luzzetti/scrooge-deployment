FROM nginx:1.27-alpine

# Copy configuration files
COPY conf/scrooge.conf /etc/nginx/conf.d/

# Copy SSL certificates
COPY certs/scrooge.io.crt /etc/nginx/certs/
COPY certs/scrooge.io.key /etc/nginx/certs/