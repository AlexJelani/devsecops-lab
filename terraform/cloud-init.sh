#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# 1. Update & install prerequisites
apt-get update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# 2. Add Docker’s official GPG key & repo if missing
KEYRING=/usr/share/keyrings/docker-archive-keyring.gpg
if [ ! -f "$KEYRING" ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --batch --yes --dearmor -o "$KEYRING"
fi

DOCKER_LIST=/etc/apt/sources.list.d/docker.list
if ! grep -q download.docker.com "$DOCKER_LIST" 2>/dev/null; then
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" \
    > "$DOCKER_LIST"
fi

# 3. Install Docker Engine & Compose plugin
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# 4. Enable & start Docker
systemctl enable docker
systemctl start docker

# 5. Prepare project directory
PROJECT_DIR=/home/ubuntu/devsecops-lab
mkdir -p "$PROJECT_DIR"

# 6. Write docker-compose.yml
cat > "$PROJECT_DIR/docker-compose.yml" << 'EOF'
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

# 7. Drop in a minimal Prometheus config
mkdir -p "$PROJECT_DIR/prometheus"
cat > "$PROJECT_DIR/prometheus/prometheus.yml" << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

# 8. Fix ownership & launch everything
chown -R ubuntu:ubuntu "$PROJECT_DIR"
cd "$PROJECT_DIR"
docker-compose pull
docker-compose up -d

echo "✅ All containers are up:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
