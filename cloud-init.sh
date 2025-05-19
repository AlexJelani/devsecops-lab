#!/bin/bash -xe

# 1. Update & install prerequisites
apt-get update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# 2. Add Docker’s official GPG key & repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

# 3. Install Docker Engine
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# 4. Install standalone Docker Compose
DOCKER_COMPOSE_VERSION=2.12.2
curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 5. Enable & start Docker
systemctl enable docker
systemctl start docker

# 6. Prepare project directory & write docker-compose.yml
PROJECT_DIR=/home/ubuntu/devsecops-lab
mkdir -p ${PROJECT_DIR}
cat <<'EOF' > ${PROJECT_DIR}/docker-compose.yml
version: '3.8'
services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx:/etc/nginx/conf.d
    networks:
      - backend

  gitea:
    image: gitea/gitea:latest
    ports:
      - "3000:3000"
    networks:
      - backend

  jenkins:
    image: jenkins/jenkins:lts
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_data:/var/jenkins_home
    networks:
      - backend

  sonarqube:
    image: sonarqube:latest
    ports:
      - "9000:9000"
    networks:
      - backend

  nexus:
    image: sonatype/nexus3
    ports:
      - "8081:8081"
    volumes:
      - nexus_data:/nexus-data
    networks:
      - backend

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus:/etc/prometheus
    networks:
      - backend

  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"
    networks:
      - backend

volumes:
  jenkins_data:
  nexus_data:

networks:
  backend:
EOF

# 7. Fix ownership & launch
chown -R ubuntu:ubuntu ${PROJECT_DIR}
cd ${PROJECT_DIR}
docker-compose up -d
