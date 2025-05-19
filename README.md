# DevSecOps Lab on OCI Free Tier

This project helps you set up a beginner-friendly DevSecOps home lab on Oracle Cloud Infrastructure (OCI) using Terraform and Docker Compose.

## 📦 Components

- **Terraform**: Provisions the OCI infrastructure  
- **Docker & Docker Compose v2**: Runs DevSecOps tools  
- **Cloud Init**: Bootstraps Docker, Docker Compose, and the compose stack

## 💻 Tools Deployed

| Service     | Port   | Notes                                        |
|-------------|--------|----------------------------------------------|
| NGINX       | 80     | Reverse proxy                               |
| Gitea       | 3000   | Git server                                  |
| Jenkins     | 8080   | CI/CD server<br>50000 (agent)                |
| SonarQube   | 9000   | Code quality & security                      |
| Nexus       | 8081   | Artifact repository                          |
| Prometheus  | 9090   | Monitoring                                  |
| Grafana     | 3001   | Dashboards (for Prometheus, others)          |

## 🚀 Quickstart

1. **Provision infrastructure**  
   Configure your OCI credentials in `terraform.tfvars` and then:
   ```bash
   terraform init && terraform apply
   ```

2. **SSH into your VM**  
   ```bash
   ssh -i ~/.ssh/YOUR_PRIVATE_KEY ubuntu@<PUBLIC_IP>
   ```

3. **Bootstrap (or re-run) the cloud-init script**  
   The script will install Docker, Docker Compose, write the `docker-compose.yml`, generate a minimal Prometheus config, and spin up all containers:
   ```bash
   chmod +x ~/cloud-init.sh
   sudo bash ~/cloud-init.sh
   ```

4. **Browse the services**  
   - http://<PUBLIC_IP> – NGINX  
   - http://<PUBLIC_IP>:3000 – Gitea  
   - http://<PUBLIC_IP>:8080 – Jenkins  
   - http://<PUBLIC_IP>:9000 – SonarQube  
   - http://<PUBLIC_IP>:8081 – Nexus  
   - http://<PUBLIC_IP>:9090 – Prometheus  
   - http://<PUBLIC_IP>:3001 – Grafana  

## 🛠 Customizing Prometheus

By default, cloud-init creates a minimal `prometheus/prometheus.yml` under the project directory so that Prometheus starts up without error.  
If you wish to customize scrape targets, alerting rules, or other settings, edit:

```
devsecops-lab/prometheus/prometheus.yml
```

Your custom file will be mounted into the container at `/etc/prometheus/prometheus.yml` on startup.

## 🧱 System Requirements (OCI Free Tier)

- VM.Standard.A1.Flex (recommend 4 OCPUs, 24 GB RAM)  
- Ubuntu 22.04  
- Boot volume ≥ 100 GB  

## 🧹 Tidying Up

- If you prefer to use the **builtin** Prometheus config (no host mount), remove the `./prometheus` volume from `docker-compose.yml` and delete the `prometheus/` folder.  
- The top-level `version:` key in `docker-compose.yml` is no longer required by Docker Compose v2 and can be removed to silence the deprecation warning.

Enjoy your DevSecOps lab!
