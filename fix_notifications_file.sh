#!/bin/bash

# Fix missing notifications.default.json file on production server
# Run this script on your Digital Ocean server

echo "Fixing notifications.default.json file..."

# Ensure the uploads directory exists (both paths for compatibility)
sudo mkdir -p /var/www/html/system/uploads
sudo mkdir -p /var/www/glintaafrica/system/uploads

# Create the file in the correct location where the app expects it
if [ ! -f "/var/www/html/system/uploads/notifications.default.json" ]; then
    echo "Creating notifications.default.json file..."
    sudo tee /var/www/html/system/uploads/notifications.default.json > /dev/null << 'EOF'
{
    "invoice_paid": {
        "subject": "Invoice Payment Received",
        "template": "Dear {customer_name},\n\nWe have received your payment for invoice #{invoice_number}.\n\nAmount Paid: {amount}\nPayment Method: {payment_method}\nTransaction ID: {transaction_id}\n\nThank you for your payment.\n\nBest regards,\n{company_name}"
    },
    "invoice_created": {
        "subject": "New Invoice Generated",
        "template": "Dear {customer_name},\n\nA new invoice has been generated for your account.\n\nInvoice Number: {invoice_number}\nAmount Due: {amount}\nDue Date: {due_date}\n\nPlease make payment before the due date to avoid service interruption.\n\nBest regards,\n{company_name}"
    },
    "payment_reminder": {
        "subject": "Payment Reminder",
        "template": "Dear {customer_name},\n\nThis is a reminder that your invoice #{invoice_number} is due soon.\n\nAmount Due: {amount}\nDue Date: {due_date}\n\nPlease make payment to avoid service interruption.\n\nBest regards,\n{company_name}"
    },
    "account_created": {
        "subject": "Welcome to {company_name}",
        "template": "Dear {customer_name},\n\nYour account has been successfully created.\n\nUsername: {username}\nPackage: {package_name}\n\nThank you for choosing our services.\n\nBest regards,\n{company_name}"
    },
    "package_activated": {
        "subject": "Package Activated",
        "template": "Dear {customer_name},\n\nYour package has been activated successfully.\n\nPackage: {package_name}\nValidity: {validity}\nExpiry Date: {expiry_date}\n\nEnjoy our services!\n\nBest regards,\n{company_name}"
    },
    "low_balance": {
        "subject": "Low Balance Alert",
        "template": "Dear {customer_name},\n\nYour account balance is running low.\n\nCurrent Balance: {balance}\nPackage: {package_name}\n\nPlease top up to continue enjoying our services.\n\nBest regards,\n{company_name}"
    },
    "service_suspended": {
        "subject": "Service Suspended",
        "template": "Dear {customer_name},\n\nYour service has been suspended due to non-payment.\n\nOutstanding Amount: {amount}\n\nPlease make payment to restore your service.\n\nBest regards,\n{company_name}"
    },
    "password_reset": {
        "subject": "Password Reset Request",
        "template": "Dear {customer_name},\n\nYou have requested to reset your password.\n\nReset Code: {reset_code}\n\nThis code will expire in 1 hour.\n\nIf you did not request this, please ignore this message.\n\nBest regards,\n{company_name}"
    }
}
EOF
fi

# Set proper ownership and permissions for both locations
sudo chown www-data:www-data /var/www/html/system/uploads/notifications.default.json
sudo chmod 644 /var/www/html/system/uploads/notifications.default.json

# Also copy to the project directory for backup
sudo cp /var/www/html/system/uploads/notifications.default.json /var/www/glintaafrica/system/uploads/notifications.default.json
sudo chown www-data:www-data /var/www/glintaafrica/system/uploads/notifications.default.json
sudo chmod 644 /var/www/glintaafrica/system/uploads/notifications.default.json

# Restart the web container to pick up the changes
cd /var/www/glintaafrica
docker-compose -f docker-compose.production.yml restart web

echo "✅ notifications.default.json file has been fixed!"
echo "✅ File permissions set to www-data:www-data"
echo "✅ Web container restarted"

# Create the file inside the container where the app expects it
docker exec glinta-web-prod mkdir -p /var/www/html/system/uploads
docker exec glinta-web-prod cp /var/www/html/system/uploads/notifications.default.json /var/www/html/system/uploads/notifications.default.json 2>/dev/null || \
docker exec glinta-web-prod tee /var/www/html/system/uploads/notifications.default.json > /dev/null << 'EOF'
{
    "invoice_paid": {
        "subject": "Invoice Payment Received",
        "template": "Dear {customer_name},\n\nWe have received your payment for invoice #{invoice_number}.\n\nAmount Paid: {amount}\nPayment Method: {payment_method}\nTransaction ID: {transaction_id}\n\nThank you for your payment.\n\nBest regards,\n{company_name}"
    },
    "invoice_created": {
        "subject": "New Invoice Generated",
        "template": "Dear {customer_name},\n\nA new invoice has been generated for your account.\n\nInvoice Number: {invoice_number}\nAmount Due: {amount}\nDue Date: {due_date}\n\nPlease make payment before the due date to avoid service interruption.\n\nBest regards,\n{company_name}"
    },
    "payment_reminder": {
        "subject": "Payment Reminder",
        "template": "Dear {customer_name},\n\nThis is a reminder that your invoice #{invoice_number} is due soon.\n\nAmount Due: {amount}\nDue Date: {due_date}\n\nPlease make payment to avoid service interruption.\n\nBest regards,\n{company_name}"
    },
    "account_created": {
        "subject": "Welcome to {company_name}",
        "template": "Dear {customer_name},\n\nYour account has been successfully created.\n\nUsername: {username}\nPackage: {package_name}\n\nThank you for choosing our services.\n\nBest regards,\n{company_name}"
    },
    "package_activated": {
        "subject": "Package Activated",
        "template": "Dear {customer_name},\n\nYour package has been activated successfully.\n\nPackage: {package_name}\nValidity: {validity}\nExpiry Date: {expiry_date}\n\nEnjoy our services!\n\nBest regards,\n{company_name}"
    },
    "low_balance": {
        "subject": "Low Balance Alert",
        "template": "Dear {customer_name},\n\nYour account balance is running low.\n\nCurrent Balance: {balance}\nPackage: {package_name}\n\nPlease top up to continue enjoying our services.\n\nBest regards,\n{company_name}"
    },
    "service_suspended": {
        "subject": "Service Suspended",
        "template": "Dear {customer_name},\n\nYour service has been suspended due to non-payment.\n\nOutstanding Amount: {amount}\n\nPlease make payment to restore your service.\n\nBest regards,\n{company_name}"
    },
    "password_reset": {
        "subject": "Password Reset Request",
        "template": "Dear {customer_name},\n\nYou have requested to reset your password.\n\nReset Code: {reset_code}\n\nThis code will expire in 1 hour.\n\nIf you did not request this, please ignore this message.\n\nBest regards,\n{company_name}"
    }
}
EOF

# Set proper permissions inside the container
docker exec glinta-web-prod chown www-data:www-data /var/www/html/system/uploads/notifications.default.json
docker exec glinta-web-prod chmod 644 /var/www/html/system/uploads/notifications.default.json

# Verify the file exists inside the container
echo "✅ File verified inside container:"
docker exec glinta-web-prod ls -la /var/www/html/system/uploads/notifications.default.json