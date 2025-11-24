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
    zip

# Install PHP extensions (PostgreSQL + Laravel requirements)
RUN docker-php-ext-install pdo_pgsql pgsql mbstring zip

# Install Composer inside container
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy app source code
COPY . .

# Install Laravel vendor dependencies
RUN composer install --no-dev --optimize-autoloader

# Fix permissions so Laravel can write logs, cache, views, sessions
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Clear cached Laravel config, views, routes
RUN php artisan config:clear && \
    php artisan route:clear && \
    php artisan view:clear

# Copy Nginx config
COPY nginx.conf /etc/nginx/sites-enabled/default

# Expose Render port
EXPOSE 80

# Start Laravel migrations, Nginx & PHP-FPM together
CMD php artisan migrate --force && service nginx start && php-fpm
