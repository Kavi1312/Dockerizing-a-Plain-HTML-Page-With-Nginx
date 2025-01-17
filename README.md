# Dockerizing a Simple HTML Page with Nginx

## **Objective**

The goal of this assignment is to familiarize yourself with Docker and containerization by Dockerizing a simple HTML page using Nginx as the web server.

---

## **Requirements**

### **1. Basic HTML Page**
- Create a plain HTML page named `index.html` with some content (e.g., "Hello, Docker!").

### **2. Nginx Configuration**
- Create an Nginx configuration file named `nginx.conf` to serve the `index.html` page.
- Configure Nginx to listen on port 80.

### **3. Dockerfile**
- Create a `Dockerfile` to define the Docker image.
- Use an official Nginx base image.
- Copy the `index.html` and `nginx.conf` files into the appropriate location in the container.
- Ensure that the Nginx server is started when the container is run.

### **4. Building the Docker Image**
- Build the Docker image using the `Dockerfile`.

### **5. Push the Image to ECR**
- Push the built image to a public repository on Amazon ECR.

### **6. Documentation**
- Provide a `README.md` file that explains the purpose of each file (`index.html`, `nginx.conf`, `Dockerfile`) and details the steps to build and run the Docker container.

### **7. Submission**
- Push all artifacts, including the public repository link, the Dockerfile, and other files, into a GitHub repository.

---

## **Implementation Steps**

### **Step 1: Create the HTML Page**

1. Create `index.html`:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Hello Docker</title>
   </head>
   <body>
       <h1>Hello, Docker!</h1>
   </body>
   </html>
   ```

### **Step 2: Create the Nginx Configuration**

1. Create `nginx.conf`:
   ```nginx
   server {
       listen 80;
       server_name localhost;

       location / {
           root /usr/share/nginx/html;
           index index.html;
       }
   }
   ```

### **Step 3: Create the Dockerfile**

1. Create `Dockerfile`:
   ```dockerfile
   FROM nginx:latest

   COPY nginx.conf /etc/nginx/nginx.conf
   COPY index.html /usr/share/nginx/html/index.html

   EXPOSE 80

   CMD ["nginx", "-g", "daemon off;"]
   ```

### **Step 4: Build the Docker Image**

1. Build the Docker image:
   ```bash
   docker build -t customized-nginx .
   ```

### **Step 5: Run the Docker Container**

1. Run the container and map it to port 81 on the host:
   ```bash
   docker run -d -p 81:80 customized-nginx
   ```

2. Access the application in the browser at:
   ```
   http://127.0.0.1:81
   ```

### **Step 6: Debugging Commands**

If there are issues, use the following commands:

- **Verify Running Containers:**
  ```bash
  docker ps
  ```

- **Inspect Container Logs:**
  ```bash
  docker logs <CONTAINER_ID>
  ```

- **Access the Container:**
  ```bash
  docker exec -it <CONTAINER_ID> /bin/bash
  ```

- **Verify Files in the Container:**
  ```bash
  ls /usr/share/nginx/html
  ```

### **Step 7: Push the Image to Amazon ECR**

1. Authenticate Docker to Amazon ECR:
   ```bash
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <ECR_repository_url>
   ```

2. Tag the image:
   ```bash
   docker tag customized-nginx:latest <ECR_repository_url>:latest
   ```

3. Push the image to the repository:
   ```bash
   docker push <ECR_repository_url>:latest
   ```

### **Step 8: Documentation**

1. Provide a `README.md` file with:
   - Explanation of each file (`index.html`, `nginx.conf`, `Dockerfile`).
   - Steps to build and run the container.

### **Step 9: Bonus (Optional)**

#### **1. Customization**
- **Objective:** Enhance the `index.html` with additional features and serve additional static files (e.g., `style.css`, `app.js`).

1. Create `style.css`:
   ```css
   body {
       font-family: Arial, sans-serif;
       background-color: #f0f0f0;
       padding: 20px;
   }
   ```

2. Create `app.js`:
   ```javascript
   console.log("Dockerized Nginx with custom static files!");
   ```

3. Update `index.html`:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Enhanced Docker Page</title>
       <link rel="stylesheet" href="style.css">
   </head>
   <body>
       <h1>Hello, Docker with Enhancements!</h1>
       <p>This page is served using Nginx in a Docker container.</p>
       <script src="app.js"></script>
   </body>
   </html>
   ```

4. Update the `Dockerfile`:
   ```dockerfile
   FROM nginx:latest

   COPY nginx.conf /etc/nginx/nginx.conf
   COPY index.html /usr/share/nginx/html/index.html
   COPY style.css /usr/share/nginx/html/style.css
   COPY app.js /usr/share/nginx/html/app.js

   EXPOSE 80

   CMD ["nginx", "-g", "daemon off;"]
   ```

#### **2. HTTPS Support**

1. Generate a self-signed SSL certificate:
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
   ```

2. Update `nginx.conf` for HTTPS:
   ```nginx
   server {
       listen 443 ssl;
       server_name localhost;

       ssl_certificate /etc/nginx/ssl/nginx.crt;
       ssl_certificate_key /etc/nginx/ssl/nginx.key;

       location / {
           root /usr/share/nginx/html;
           index index.html;
       }
   }

   server {
       listen 80;
       server_name localhost;

       return 301 https://$host$request_uri;
   }
   ```

3. Update `Dockerfile`:
   ```dockerfile
   FROM nginx:latest

   COPY nginx.conf /etc/nginx/nginx.conf
   COPY index.html /usr/share/nginx/html/index.html
   COPY style.css /usr/share/nginx/html/style.css
   COPY app.js /usr/share/nginx/html/app.js
   COPY nginx.crt /etc/nginx/ssl/nginx.crt
   COPY nginx.key /etc/nginx/ssl/nginx.key

   EXPOSE 80 443

   CMD ["nginx", "-g", "daemon off;"]
   ```

#### **3. Docker Compose**

1. Create `docker-compose.yml`:
   ```yaml
   version: "3.8"
   services:
     nginx:
       image: customized-nginx
       build:
         context: .
       ports:
         - "81:80"
         - "443:443"
   ```

2. Build and Run:
   ```bash
   docker-compose up --build
   ```

3. Access the application at:
   - HTTP: `http://127.0.0.1:81`
   - HTTPS: `https://127.0.0.1`

---

## **Submission**
- Push all files to your GitHub repository.
- Include the Amazon ECR repository link in the `README.md` file.

---


--![image](https://github.com/user-attachments/assets/73b330a2-aeeb-48c8-8929-cf045580b624)

  
 --![image](https://github.com/user-attachments/assets/4cfb1567-5dc3-4cb0-99ac-e5aa1ee811e2)


--![image](https://github.com/user-attachments/assets/d3b721c1-ab94-4cf7-b7ee-fd4df401033a)


## **3. Troubleshooting Steps**

### **Issue 1: Docker Engine Not Running**
- If you encounter `docker: Error response from daemon` or similar issues, ensure Docker Desktop is running:
  - Open Docker Desktop and wait for it to initialize.
  - Verify Docker is running by checking:
    ```bash
    docker info
    ```

### **Issue 2: File Not Found in Build Context**
- If `nginx.conf` or `index.html` is not found, ensure they are in the same directory as the `Dockerfile`.
- Use `ls` to confirm:
  ```bash
  ls
  ```

### **Issue 3: Unable to Tag or Push Image**
- Ensure you’re logged in to AWS ECR:
  ```bash
  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
  ```

- Rebuild the image if necessary:
  ```bash
  docker build -t my-nginx-image .
  ```

### **Issue 4: Unable to Access Locally Hosted Page**
- Verify the container is running:
  ```bash
  docker ps
  ```

- If it’s not running, restart the container:
  ```bash
  docker run -d -p 80:80 my-nginx-image
  ```

- Ensure port `80` is not blocked or used by another process.

---

## **4. Final Verification**

- Test the setup locally:
  - Open a browser and navigate to `http://localhost`.
  - Ensure the page displays the `index.html` content.

- Verify the image in AWS ECR:
  - Check your repository in the AWS Management Console to confirm the image is listed.

---

## **5. Submission**

1. Push all the project files (`index.html`, `nginx.conf`, `Dockerfile`, `README.md`) to your GitHub repository.
2. Include the AWS ECR public repository link in `README.md`.
3. Share the GitHub repository link for submission.

---


