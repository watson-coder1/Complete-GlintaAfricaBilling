# 🚀 Glinta Africa Production Deployment Guide

Complete guide to deploy your Glinta Africa billing system to Digital Ocean with domain `glintaafrica.com`.

## 📋 Pre-Deployment Checklist

### 1. Digital Ocean Account Setup
- [ ] Create Digital Ocean account
- [ ] Add payment method
- [ ] Generate SSH key pair

### 2. Domain Configuration
- [ ] Point glintaafrica.com DNS to your droplet IP
- [ ] Configure www subdomain

### 3. M-Pesa Production Credentials
- [ ] Get production credentials from Safaricom Developer Portal
- [ ] Obtain business shortcode
- [ ] Get production passkey

## 🛠️ Step 1: Create Digital Ocean Droplet

```bash
# Recommended Specifications:
# - Ubuntu 22.04 LTS
# - 2 vCPUs, 2GB RAM, 50GB SSD ($12/month)
# - Region: Frankfurt or London (closest to Kenya)
# - Add your SSH key
# - Name: glinta-africa-production
```

## 🌐 Step 2: Configure Domain DNS

Configure these DNS records at your domain registrar:

```dns
Type    Name                Value
A       glintaafrica.com    YOUR_DROPLET_IP
A       www                 YOUR_DROPLET_IP
CNAME   admin               glintaafrica.com
CNAME   api                 glintaafrica.com
```

## 🔧 Step 3: Server Setup

### SSH into your droplet:
```bash
ssh root@YOUR_DROPLET_IP
```

### Run the deployment script:
```bash
# Upload and run the deployment script
chmod +x deploy_production.sh
./deploy_production.sh

# Activate Docker group
newgrp docker
```

## 📦 Step 4: Deploy Application

### Clone your repository:
```bash
cd /var/www/glintaafrica
git clone https://github.com/watson-coder1/Complete-GlintaAfricaBilling.git .

# Set proper permissions
sudo chown -R www-data:www-data /var/www/glintaafrica
sudo chmod -R 755 /var/www/glintaafrica
```

### Configure environment variables:
```bash
# Copy and edit environment file
cp .env.production .env
nano .env

# Update these critical values:
# - MYSQL_ROOT_PASSWORD
# - MYSQL_PASSWORD
# - MPESA_CONSUMER_KEY
# - MPESA_CONSUMER_SECRET
# - MPESA_BUSINESS_SHORTCODE
# - MPESA_PASSKEY
```

### Update production config:
```bash
# Backup original config
cp config.php config.php.backup

# Use production config
cp production_config_new.php config.php
```

## 🐳 Step 5: Deploy with Docker

```bash
# Build and start containers
docker-compose -f docker-compose.production.yml up -d

# Check container status
docker-compose -f docker-compose.production.yml ps

# View logs
docker-compose -f docker-compose.production.yml logs -f web
```

## 🌐 Step 6: Configure Nginx

```bash
# Copy Nginx configuration
sudo cp nginx.production.conf /etc/nginx/sites-available/glintaafrica.com

# Enable the site
sudo ln -s /etc/nginx/sites-available/glintaafrica.com /etc/nginx/sites-enabled/

# Remove default site
sudo rm /etc/nginx/sites-enabled/default

# Test Nginx configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx
```

## 🔒 Step 7: Setup SSL Certificate

```bash
# Get SSL certificate from Let's Encrypt
sudo certbot --nginx -d glintaafrica.com -d www.glintaafrica.com

# Test automatic renewal
sudo certbot renew --dry-run

# Set up automatic renewal
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -
```

## 📊 Step 8: Database Setup

```bash
# Connect to MySQL container
docker exec -it glinta-mysql-prod mysql -u root -p

# Create database and import your data
CREATE DATABASE IF NOT EXISTS glinta_billing;
USE glinta_billing;

# Exit MySQL and import your database dump if you have one
# docker exec -i glinta-mysql-prod mysql -u root -p glinta_billing < your_database_dump.sql
```

## 🔧 Step 9: M-Pesa Production Configuration

### Update M-Pesa settings in admin panel:
1. Login to admin panel: `https://glintaafrica.com/admin`
2. Go to Payment Gateways > Daraja (M-Pesa)
3. Update settings:
   - Environment: Production
   - Consumer Key: Your production key
   - Consumer Secret: Your production secret
   - Business Shortcode: Your shortcode
   - Passkey: Your production passkey
   - Callback URL: `https://glintaafrica.com/callback_mpesa.php`

## 🧪 Step 10: Testing

### Test the following:
- [ ] Landing page loads: `https://glintaafrica.com`
- [ ] Admin login works: `https://glintaafrica.com/admin`
- [ ] Customer portal: `https://glintaafrica.com/customer`
- [ ] SSL certificate is valid
- [ ] M-Pesa STK push works
- [ ] Captive portal redirects properly
- [ ] Email notifications work

### Test M-Pesa Integration:
```bash
# Test callback URL is accessible
curl -X POST https://glintaafrica.com/callback_mpesa.php \
  -H "Content-Type: application/json" \
  -d '{"test": "callback"}'
```

## 🔍 Step 11: Monitoring & Logs

### View application logs:
```bash
# Web application logs
docker-compose -f docker-compose.production.yml logs -f web

# MySQL logs
docker-compose -f docker-compose.production.yml logs -f mysql

# RADIUS logs
docker-compose -f docker-compose.production.yml logs -f freeradius

# Nginx logs
sudo tail -f /var/log/nginx/glintaafrica.com.access.log
sudo tail -f /var/log/nginx/glintaafrica.com.error.log
```

### System monitoring:
```bash
# Check system resources
htop

# Check disk space
df -h

# Check Docker containers
docker ps
docker stats
```

## 🛡️ Step 12: Security Hardening

### Configure fail2ban:
```bash
sudo apt install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Set up automatic backups:
```bash
# Create backup script
sudo mkdir -p /var/backups/glinta
sudo crontab -e

# Add daily backup at 2 AM
0 2 * * * docker exec glinta-mysql-prod mysqldump -u root -p$MYSQL_ROOT_PASSWORD glinta_billing > /var/backups/glinta/db_backup_$(date +%Y%m%d).sql
```

## 🎯 Step 13: Performance Optimization

### Configure Redis cache:
```bash
# Redis is already included in docker-compose
# Update your application to use Redis for caching
```

### Enable Gzip compression:
```bash
# Already configured in Nginx config
# Verify it's working:
curl -H "Accept-Encoding: gzip" -I https://glintaafrica.com
```

## 🚨 Troubleshooting

### Common Issues:

1. **Container won't start:**
   ```bash
   docker-compose -f docker-compose.production.yml logs container_name
   ```

2. **SSL certificate issues:**
   ```bash
   sudo certbot certificates
   sudo certbot renew
   ```

3. **M-Pesa callbacks not working:**
   - Check Nginx logs
   - Verify callback URL is accessible
   - Check M-Pesa credentials

4. **Database connection issues:**
   ```bash
   docker exec -it glinta-mysql-prod mysql -u root -p
   ```

5. **Permission issues:**
   ```bash
   sudo chown -R www-data:www-data /var/www/glintaafrica
   sudo chmod -R 755 /var/www/glintaafrica
   ```

## 📞 Support

If you encounter issues:
1. Check the logs first
2. Verify all environment variables are set
3. Ensure all containers are running
4. Test M-Pesa credentials in Safaricom portal

## 🎉 Success!

Your Glinta Africa billing system should now be live at:
- **Landing Page:** https://glintaafrica.com
- **Admin Panel:** https://glintaafrica.com/admin  
- **Customer Portal:** https://glintaafrica.com/customer
- **Database Admin:** https://glintaafrica.com/phpmyadmin

---

**Next Steps:**
1. Configure your WiFi routers to use the captive portal
2. Set up your M-Pesa business account
3. Test the complete payment flow
4. Train your team on the admin panel
5. Start onboarding customers!