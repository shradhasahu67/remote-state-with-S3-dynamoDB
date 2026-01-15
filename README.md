# Terraform + Ansible Multi-Environment Automation

## 📌 Overview
This project demonstrates end-to-end DevOps automation using **Terraform** and **Ansible** to provision and configure **Dev, Staging, and Production** environments on AWS.

The infrastructure is created using Infrastructure as Code (IaC) principles and configured using Ansible roles.

---
🧩 Project Overview

The project covers:

Infrastructure provisioning using Terraform

Multi-environment setup (dev / stg / prod)

AWS EC2, S3, and DynamoDB resources

Dynamic Ansible inventories generated from Terraform outputs

Automated Nginx installation using Ansible roles

End-to-end Infrastructure as Code (IaC)

🏗️ Architecture Diagram


## ⚙️ Tools & Technologies
- Terraform
- Ansible
- AWS EC2
- Bash scripting
- Git & GitHub

---


---

## 🚀 How It Works

⚙️ Infrastructure Provisioning with Terraform
1️⃣ Initialize Terraform
terraform init:
![alt text](image.png)

2️⃣ Review the Execution Plan
terraform plan:
![alt text](image-1.png)


3️⃣ Apply Infrastructure
terraform apply:
![alt text](image-2.png)


You can see below that all instance , buckets ,dynamodb are running or created , which is created through Terraform :

![alt text](image-3.png)
![alt text](image-4.png)
![alt text](image-5.png)
![alt text](image-6.png)

🔁 Dynamic Inventory with Ansible
The update_inventories.sh script:

Reads Terraform outputs

Automatically updates Ansible inventories for:
dev
stg
prod

7️⃣ Ansible Role Creation

Initialized an Nginx role using Ansible Galaxy

Created reusable tasks for:

Installing Nginx

Starting and enabling service

Deploying a custom web page

8️⃣ Configuration Management

Ran Ansible playbooks for each environment:

Dev

Staging

Production

Ensured consistent configuration across all EC2 instances


