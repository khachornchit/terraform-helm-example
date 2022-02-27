#FROM nginx:alpine
FROM nginx:latest

COPY nginx/default.conf /etc/nginx/conf.d/
COPY nginx/maintenance.html /usr/share/nginx/html/maintenance.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]