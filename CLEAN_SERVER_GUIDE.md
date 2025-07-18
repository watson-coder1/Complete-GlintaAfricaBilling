# 🧹 Clean Server Before Deployment - Safety Guide

## ⚠️ **IMPORTANT: BACKUP FIRST!**

Before deleting anything, let's safely backup your existing data and then clean the server for fresh deployment.

---

## 🔒 **Step 1: Create Backup (ESSENTIAL)**

```bash
# SSH to your server
ssh root@your-server-ip

# Create backup directory with timestamp
BACKUP_DIR="/root/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup existing website files
if [ -d "/var/www/html" ]; then
    echo "📦 Backing up /var/www/html..."
    cp -r /var/www/html "$BACKUP_DIR/website_backup"
fi

# Backup databases (if you have any important data)
echo "🗃️ Backing up databases..."
mysqldump --all-databases > "$BACKUP_DIR/all_databases_backup.sql" 2>/dev/null || echo "No MySQL databases found"

# Backup any other important directories
if [ -d "/etc/apache2" ]; then
    cp -r /etc/apache2 "$BACKUP_DIR/apache2_config"
fi

if [ -d "/etc/nginx" ]; then
    cp -r /etc/nginx "$BACKUP_DIR/nginx_config"
fi

echo "✅ Backup completed at: $BACKUP_DIR"
ls -la "$BACKUP_DIR"
```

---

## 🗑️ **Step 2: Clean Web Directory**

```bash
# Stop web server (choose your server type)
systemctl stop apache2  # For Apache
# OR
systemctl stop nginx     # For Nginx

# Remove old website files
echo "🧹 Cleaning /var/www/html..."
rm -rf /var/www/html/*
rm -rf /var/www/html/.[^.]*  # Remove hidden files too

# Verify directory is clean
ls -la /var/www/html/
```

---

## 🎯 **Step 3: Clean Other Common Directories**

```bash
# Clean temporary files
echo "🧹 Cleaning temporary files..."
rm -rf /tmp/*
rm -rf /var/tmp/*

# Clean old Docker containers (if any)
if command -v docker &> /dev/null; then
    echo "🐳 Cleaning Docker..."
    docker stop $(docker ps -aq) 2>/dev/null || true
    docker rm $(docker ps -aq) 2>/dev/null || true
    docker system prune -f
fi

# Clean old downloads (common locations)
if [ -d "/root/downloads" ]; then
    echo "🗂️ Cleaning /root/downloads..."
    rm -rf /root/downloads/*
fi

if [ -d "/home/*/Downloads" ]; then
    echo "🗂️ Cleaning user downloads..."
    rm -rf /home/*/Downloads/*
fi
```

---

## 🔄 **Step 4: Reset Database (Optional)**

**⚠️ Only if you want to start with completely fresh databases:**

```bash
# Stop MySQL/MariaDB
systemctl stop mysql
# OR
systemctl stop mariadb

# Remove database files (CAUTION: This deletes ALL data!)
rm -rf /var/lib/mysql/*

# Start MySQL/MariaDB
systemctl start mysql
# OR  
systemctl start mariadb

# Secure MySQL installation
mysql_secure_installation
```

**Note:** Skip this step if you want to keep existing database data.

---

## 🌐 **Step 5: Fresh Deployment**

After cleaning, deploy your new system:

```bash
# Clone your Glinta Africa system
cd /var/www/
git clone https://github.com/watson-coder1/GlintaAfricaBilling-with-radius-final.git html

# Set proper permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 777 /var/www/html/system/uploads
chmod -R 777 /var/www/html/system/cache

# Make deployment script executable
chmod +x /var/www/html/deploy_to_production.sh

# Run deployment
cd /var/www/html
./deploy_to_production.sh

# Start web server
systemctl start apache2  # For Apache
# OR
systemctl start nginx     # For Nginx
```

---

## 📋 **Alternative: Selective Cleanup**

If you want to keep some things and only remove specific items:

```bash
# List what's currently in /var/www/html
ls -la /var/www/html/

# Remove only specific directories/files
rm -rf /var/www/html/old_project_name
rm -rf /var/www/html/test_files
rm -rf /var/www/html/backup_*

# Keep config files if needed
# mv /var/www/html/important_config.php /root/keep_this_config.php
```

---

## ✅ **Safe Cleanup Checklist**

### **Before Starting:**
- [ ] SSH access to server confirmed
- [ ] Backup created and verified
- [ ] Important data identified and saved
- [ ] Web server access confirmed

### **During Cleanup:**
- [ ] Stop web services before removing files
- [ ] Double-check paths before running rm commands
- [ ] Keep backups safe in /root/backup_* directory
- [ ] Verify cleanup completed successfully

### **After Cleanup:**
- [ ] Deploy new Glinta Africa system
- [ ] Configure database settings
- [ ] Test website accessibility
- [ ] Verify all features working

---

## 🆘 **Emergency Recovery**

If something goes wrong:

```bash
# Restore from backup
BACKUP_DIR="/root/backup_YYYYMMDD_HHMMSS"  # Use your actual backup directory

# Restore website files
rm -rf /var/www/html/*
cp -r "$BACKUP_DIR/website_backup/"* /var/www/html/

# Restore database (if needed)
mysql < "$BACKUP_DIR/all_databases_backup.sql"

# Restart services
systemctl restart apache2  # or nginx
systemctl restart mysql    # or mariadb
```

---

## 💡 **Best Practices**

1. **Always backup first** - Never delete without a backup
2. **Test in staging** - If possible, test cleanup on a staging server first
3. **Keep backups** - Don't delete backups for at least 30 days
4. **Document changes** - Keep notes of what you removed
5. **Monitor after deployment** - Check logs and functionality

---

## 🎯 **Quick Commands for Common Scenarios**

### **Scenario 1: Fresh Start (Recommended)**
```bash
# Backup, clean everything, fresh install
./clean_and_deploy_fresh.sh
```

### **Scenario 2: Keep Database, Fresh Website**
```bash
# Backup and clean only web files
cp -r /var/www/html /root/backup_website_$(date +%Y%m%d)
rm -rf /var/www/html/*
# Then deploy new system
```

### **Scenario 3: Selective Cleanup**
```bash
# Remove only specific old projects
rm -rf /var/www/html/old_billing_system
rm -rf /var/www/html/test_site
# Keep everything else
```

---

**Choose the approach that best fits your situation. The most important thing is to backup first! 🔒**

*Ready to proceed with server cleanup and fresh deployment!*