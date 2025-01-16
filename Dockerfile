#For base image creation used a specific version of nginx
FROM nginx:latest
COPY index.html /usr/share/nginx/html/

# Copy the `index.html` and `nginx.conf` files into the appropriate location in the container
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Add a health check for Nginx
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s CMD curl -f http://localhost:80 || exit 1

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
