
## Documentation
# DevOps Internship Assessment

### 1. Clone the Repository

```bash
git clone https://github.com/Ankit6098/Todo-List-nodejs.git
cd Todo-List-nodejs
```
### 2. Set Up my Own MongoDB Database

I visited MongoDB Atlas and performed the following steps:

Created a free MongoDB cluster
Created a database
Added a user with proper credentials
Whitelisted my IP address to allow access
Generated my own connection string (URI)

Then, I edited the .env file in the root directory and added my own URI.

### 3. Dockerization of the Node.js App

The Dockerfile is based on a lightweight Node.js image to keep the final container small and efficient. It sets a working directory inside the container, installs the application's dependencies, copies the full source code into the container, exposes the necessary port for the app to run, and defines the command to start the application.

```docker
# Use a lightweight Node.js base image
FROM node:lts-alpine3.22

# Set the working directory in the container
WORKDIR /usr/app

# Copy only package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all application source code
COPY . .

# Expose the port the app runs on
EXPOSE 4000

# Start the application
CMD ["npm", "start"]
```
### 4. CI/CD with GitHub Actions & Docker Hub

I created a private Docker Hub repository to store the app's Docker images.

Then I:

Created GitHub Secrets:
DOCKER_USERNAME: Docker Hub username
DOCKER_PASSWORD: Docker Hub access token

Created the following GitHub Actions workflow file under .github/workflows/docker-build.yml. This workflow automatically builds a Docker image from the app and pushes it to the private Docker Hub repo on every push to the master branch.

Each image is tagged with the Git short commit hash (e.g., a1b2c3d).
This makes it easy to:

Identify exactly which version of the code is in each image

Use image automation tools to detect new images and automatically trigger Kubernetes deployments.

### 5. Infrastructure Provisioning with Terraform (AWS EC2)

To execute and host this app on the cloud, I used Terraform to provision a public Ubuntu EC2 instance on AWS.

Key components in my Terraform setup:
A VPC, subnet, and internet gateway for networking

An EC2 instance (Ubuntu, t3.medium) in a public subnet

Security groups allowing:

HTTP (port 80)
SSH (port 22)
NodePort access (port 31000)

A key pair for secure SSH access

This setup allows me to deploy and access my containerized application on the EC2 instance from the internet securely.

### 6. Infrastructure Automation with Ansible

To configure the Ubuntu server, I wrote an Ansible playbook to:

Install Docker and add user to the Docker group
Install and configure Minikube using Docker as the driver
Install kubectl to interact with the local cluster

### 7. Kubernetes Deployment

I wrote Kubernetes manifests to deploy the application in a Kubernetes cluster.

The manifests define a Deployment, a Secret for storing the MongoDB URI securely, and a NodePort Service to expose the app.

The Deployment uses the Docker image stored in my private Docker Hub repository.

I also configured Kubernetes to pull the image using a Docker Hub image pull secret.

Readiness and liveness probes were defined to help Kubernetes monitor the app's health and ensure high availability.

### 8. Accessing the Application

After deploying the app to a Kubernetes cluster using a NodePort service, the application becomes accessible externally through the following approach:

Obtain the Public IP:
Get the public IP address of the node where the application is deployed.
This will be the instance's public IP.

Get the NodePort:
The NodePort value is defined in the Kubernetes Service manifest or retrieved by describing the service.
This port (usually between 30000–32767) is exposed by the cluster to allow access from outside.

Build the URL:

```php-template
http://<PUBLIC-IP>:<NODE-PORT>
```
