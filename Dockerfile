# Use the official PHP image with Apache
FROM php:7.4-apache
EXPOSE 80
# Install necessary PHP extensions and cron
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    zip \
    unzip \
    cron \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-install zip

# copy contents into directory
COPY . /var/www/html

# Set appropriate permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Set working directory
WORKDIR /var/www/html

# Setup cron jobs
RUN echo "*/5 * * * * cd /var/www/html/system/ && /usr/local/bin/php cron.php" | crontab - \
    && echo "0 7 * * * cd /var/www/html/system/ && /usr/local/bin/php cron_reminder.php" | crontab -

# Create startup script
RUN echo '#!/bin/bash\nservice cron start\napache2-foreground' > /start.sh \
    && chmod +x /start.sh

CMD ["/start.sh"]