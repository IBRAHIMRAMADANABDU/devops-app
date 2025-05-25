
# DevOps Project - Overview and Running Instructions

## Project Overview
This project automates the deployment of a frontend and backend application using a full DevOps pipeline:

- **Terraform:** Provision infrastructure on AWS (EC2 instances, RDS)
- **Ansible:** Configure servers by installing Docker, Kubernetes tools, and other dependencies
- **Docker:** Build, push, and run containerized frontend and backend apps
- **Jenkins:** Automate the entire build and deployment process

---

## Prerequisites
- Jenkins installed and configured with Docker permissions
- AWS CLI configured for Terraform
- Terraform installed
- Ansible installed
- Docker installed and running (on your local machine or servers)
- DockerHub account and credentials set up in Jenkins
- GitHub repository access

---

## How to Run the Project

### 1. Provision Infrastructure with Terraform
Initialize and apply Terraform configs to create AWS resources:
```bash
terraform init
terraform apply
```

### 2. Configure Servers Using Ansible
Run the Ansible playbook to install Docker, Kubernetes tools, and configure your servers:
```bash
ansible-playbook -i inventory.ini setup.yml
```
- **Inventory file** (`inventory.ini`) lists your target servers.
- **Playbook** (`setup.yml`) installs:
  - Docker and Docker Compose
  - Kubernetes tools (kubeadm, kubelet, kubectl)
  - Other dependencies and configurations

### 3. Build Docker Images
You can build Docker images either locally or through Jenkins:
```bash
docker build -t your_dockerhub_username/frontend:latest ./frontend
docker build -t your_dockerhub_username/backend:latest ./backend
```

### 4. Push Docker Images to Docker Hub
Login and push your images:
```bash
docker login
docker push your_dockerhub_username/frontend:latest
docker push your_dockerhub_username/backend:latest
```

### 5. Deploy Docker Containers
Stop existing containers if any, then run new containers:
```bash
docker rm -f frontend || true
docker rm -f backend || true

docker run -d --name frontend -p 8081:80 your_dockerhub_username/frontend:latest
docker run -d --name backend -p 5000:5000 your_dockerhub_username/backend:latest
```

---

## Quick Summary of Tools

### Terraform
- **Purpose:** Provision AWS infrastructure (EC2 instances, RDS database)
- **Commands:**
  - `terraform init` — Initialize terraform
  - `terraform apply` — Apply the infrastructure changes

### Ansible
- **Purpose:** Automate server configuration
- **Typical Usage:**
  - Define inventory file (`inventory.ini`) with your hosts
  - Write playbook (`setup.yml`) to install Docker, Kubernetes, etc.
  - Run playbook:
    ```bash
    ansible-playbook -i inventory.ini setup.yml
    ```

### Docker
- **Purpose:** Containerize applications and run them in isolated environments
- **Commands:**
  - Build image:  
    `docker build -t username/appname:tag path_to_dockerfile`
  - Run container:  
    `docker run -d --name container_name -p host_port:container_port image_name:tag`
  - Remove container:  
    `docker rm -f container_name`
  - Push image to Docker Hub:  
    `docker push username/appname:tag`

---

## Useful Commands Summary

| Task                          | Command                                         |
|------------------------------|------------------------------------------------|
| Initialize Terraform           | `terraform init`                                |
| Apply Terraform changes        | `terraform apply`                               |
| Run Ansible Playbook           | `ansible-playbook -i inventory.ini setup.yml`  |
| Build Docker image (frontend)  | `docker build -t user/frontend:latest ./frontend` |
| Build Docker image (backend)   | `docker build -t user/backend:latest ./backend`   |
| Docker login                  | `docker login`                                  |
| Push Docker image             | `docker push user/frontend:latest`              |
| Run frontend container         | `docker run -d --name frontend -p 8081:80 user/frontend:latest` |
| Run backend container          | `docker run -d --name backend -p 5000:5000 user/backend:latest` |

---

## Notes
- Replace `your_dockerhub_username` with your Docker Hub username.
- Ensure Jenkins has permissions to run Docker commands.
- Ansible inventory and playbook files should reflect your actual infrastructure.
- This guide assumes you have basic understanding of Terraform, Ansible, Docker, and Jenkins.

---
![Website Screenshot](![Screenshot 2025-05-25 070852](https://github.com/user-attachments/assets/2c1080d8-7971-4e44-acbb-25b4e47bf67b)
)
