# DevSecOps Lab on OCI Free Tier

This project helps you set up a beginner-friendly DevSecOps home lab on Oracle Cloud Infrastructure (OCI) using Terraform and Docker.

## 📦 Components

- **Terraform**: Provisions the OCI infrastructure
- **Docker + Docker Compose**: Runs DevSecOps tools
- **Cloud Init**: Automatically installs necessary packages

## 💻 Tools Deployed

- Gitea (Git server)
- Jenkins (CI/CD)
- SonarQube (Code quality and security)
- Nexus (Artifact management)
- Prometheus + Grafana (Monitoring)
- NGINX (Reverse proxy)

## 🚀 How to Use

1. Configure `terraform.tfvars` with your OCI credentials
2. Run `terraform init && terraform apply`
3. SSH into your instance and run:
   ```bash
   cd ~/devsecops-lab
   docker-compose up -d
   ```

## 🧱 System Requirements (OCI Free Tier)

- VM.Standard.A1.Flex (4 OCPUs, 24GB RAM)
- Ubuntu 22.04
- Boot volume ≥ 100GB

Enjoy your DevSecOps lab!
