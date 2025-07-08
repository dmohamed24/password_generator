# Strong Password Generator App - Architecture Evolution Project

## 📋 Introduction

A case study and hands-on project that evolves from a simple Node.js app to a highly available, fully automated, and monitored AWS architecture.

---

## 🗂️ Architecture Evolution

### 1️⃣ Simple App

- Node.js + Express app
- Manual deployment on EC2

### 2️⃣ Containerization

- Created Dockerfile
- Push images to Docker Hub

### 3️⃣ CI/CD with GitHub Actions

- Build and test app
- Push Docker image
- Deploy to EC2 automatically using Terraform

### 4️⃣ High Availability & Scalability

- Created ASG and ALB using Terraform
- Zero downtime deployments

### 5️⃣ Efficient Container-Level Load Balancing (Caddy Reverse Proxy)

- Added Caddy as a reverse proxy within EC2 instances
- Each EC2 instance runs **2 Docker containers** of the app
- Caddy automatically load balances traffic between containers
- Leverages Caddy’s service discovery and dynamic routing
- Reduces cost by minimizing EC2 instance count while scaling via containers

### 6️⃣ Monitoring & Alarms

- Integrated CloudWatch
- Created alerts and dashboards
- Auto-scaling policies

**Benefits:**

- ✅ Lower AWS costs by using fewer EC2 instances
- ✅ Simplified architecture by handling container load balancing internally
- ✅ Improved resource utilization
- ✅ Flexible and dynamic container management

---

## 📹 Video Series

Each video in the series will cover one of the steps above:

1. Intro and Setup
2. Containerization
3. CI/CD
4. High Availability & Scalability
5. Container Load Balancing with Caddy
6. Monitoring and Alarms

---

## ⚡️ Technologies Used

- Node.js, Express
- Docker
- GitHub Actions
- AWS (EC2, ASG, ALB, ECR, CloudWatch)
- Terraform
- Caddy (Reverse Proxy / Load Balancer)
- IAM roles and policies
- Email Alerts via SNS

---

### 🔁 Updated Architecture Overview

User
↓
[Route53]
↓
[ALB]
↓
[ASG (EC2 instances)]
↳ [Caddy Reverse Proxy]
↳ [App Container 1]
↳ [App Container 2]
↳ [Internal Load Balancing]
↓
[Docker Images from ECR]

Monitoring:
↳ CloudWatch Metrics, Logs, Alarms
↳ Auto Scaling Triggers

---

## 👇 Getting Started

Instructions for local setup and deployment.

---

## 🚀 Demo

[Link to Video Demo]

---

## 📖 Learnings & Challenges

Highlights and lessons learned from this project.

---
