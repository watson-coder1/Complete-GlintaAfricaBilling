#!/bin/bash

# Glinta Africa Production Deployment Script
# Run this on your Digital Ocean droplet

set -e

echo "🚀 Starting Glinta Africa Production Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# System Updates
echo -e "${YELLOW}📦 Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

# Install required packages
echo -e "${YELLOW}🛠️ Installing required packages...${NC}"
sudo apt install -y \
    curl \
    wget \
    git \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    ufw \
    htop \
    nano

# Install Docker
echo -e "${YELLOW}🐳 Installing Docker...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker $USER

# Install Docker Compose
echo -e "${YELLOW}🔧 Installing Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Nginx
echo -e "${YELLOW}🌐 Installing Nginx...${NC}"
sudo apt install -y nginx

# Install Certbot for SSL
echo -e "${YELLOW}🔒 Installing Certbot for SSL...${NC}"
sudo apt install -y certbot python3-certbot-nginx

# Configure Firewall
echo -e "${YELLOW}🔥 Configuring UFW Firewall...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 'Nginx Full'
sudo ufw allow 3306  # MySQL
sudo ufw allow 1812  # RADIUS Auth
sudo ufw allow 1813  # RADIUS Accounting
sudo ufw --force enable

# Create application directory
echo -e "${YELLOW}📁 Creating application directory...${NC}"
sudo mkdir -p /var/www/glintaafrica
sudo chown -R $USER:$USER /var/www/glintaafrica

# Clone repository (you'll need to do this manually with your credentials)
echo -e "${GREEN}✅ Server setup complete!${NC}"
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "1. Clone your repository to /var/www/glintaafrica"
echo "2. Configure production environment variables"
echo "3. Set up SSL certificates"
echo "4. Deploy Docker containers"
echo ""
echo -e "${GREEN}🎉 Run 'newgrp docker' to activate Docker group membership${NC}"