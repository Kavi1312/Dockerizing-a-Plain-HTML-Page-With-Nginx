# Dockerizing-a-Plain-HTML-Page-With-Nginx
# **Dockerizing a Plain HTML Page Using Nginx**

This guide outlines the step-by-step process for Dockerizing a simple HTML page with Nginx, pushing the image to AWS ECR, and running the container locally. Troubleshooting steps are also included to resolve common issues.

---

## **1. Prerequisites**
- Install Docker Desktop and ensure it’s running.
- Set up AWS CLI with proper credentials.
- Create an AWS ECR repository.

---

## **2. Steps to Dockerize the HTML Page**

### **Step 1: Create the Project Files**

- Create a directory and navigate into it:
  ```bash
  mkdir docker-nginx-html
  cd docker-nginx-html
  ```
  ```

- Create `nginx.conf`:
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

- Create `Dockerfile`:
  ```dockerfile
  FROM nginx:latest

  COPY index.html /usr/share/nginx/html/index.html
  COPY nginx.conf /etc/nginx/conf.d/default.conf

  EXPOSE 80

  CMD ["nginx", "-g", "daemon off;"]
  ```

---

### **Step 2: Build the Docker Image**

- Build the Docker image:
  ```bash
  docker build -t my-nginx-image .
  ```

- Verify the image exists locally:
  ```bash
  docker images
  ```

-![image](https://github.com/user-attachments/assets/73b330a2-aeeb-48c8-8929-cf045580b624)


### **Step 3: Push the Image to AWS ECR**

1. **Log in to AWS ECR**:
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
   ```

2. **Tag the Docker Image**:
   ```bash
   docker tag my-nginx-image:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/my-nginx-image:latest
   ```

3. **Push the Image to ECR**:
   ```bash
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/my-nginx-image:latest
   ```

4. **Make the ECR Repository Public**:
   - Go to the AWS Management Console and set the repository's permissions to "Public."

---

### **Step 4: Run the Docker Container Locally**

- Run the container:
  ```bash
  docker run -d -p 80:80 my-nginx-image
  ```
  ![image](https://github.com/user-attachments/assets/4cfb1567-5dc3-4cb0-99ac-e5aa1ee811e2)


- Verify the page is accessible at:
  ```
  http://localhost
  ```
 ## **172.27.4.32:81**

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


