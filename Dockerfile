FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    curl \
    unzip \
    libpq-dev \
    libonig-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql mbstring zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copy app files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Clear Laravel caches
RUN php artisan config:clear && \
    php artisan route:clear && \
    php artisan view:clear

# Copy Nginx config file
COPY nginx.conf /etc/nginx/sites-enabled/default

# Expose port for Render to detect
EXPOSE 80

# Start nginx and php-fpm
CMD service nginx start && php-fpm
