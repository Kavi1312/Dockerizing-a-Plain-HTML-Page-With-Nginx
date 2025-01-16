# Use the official Nginx base image from Docker Hub
FROM nginx:latest

# Copy the custom nginx.conf to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the index.html file to the default Nginx directory
COPY index.html /usr/share/nginx/html/index.html

COPY style.css /usr/share/nginx/html/style.css
COPY app.js /usr/share/nginx/html/app.js
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
