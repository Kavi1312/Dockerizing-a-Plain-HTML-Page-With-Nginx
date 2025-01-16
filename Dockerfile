# Use the official Nginx base image from Docker Hub
FROM nginx:latest

# Copy the custom nginx.conf to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the index.html file to the default Nginx directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
