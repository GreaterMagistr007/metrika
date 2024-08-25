FROM ubuntu:24.10

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
        software-properties-common \
        apt-transport-https \
        wget \
        unzip \
        git \
        build-essential \
        libpq-dev \
        php-fpm \
        php-mysql \
        php-gd \
        php-xml \
        php-json \
        php-mbstring \
        php-zip \
        php-intl \
        apache2 \
        nginx \
        nano \
        iputils-ping \
        sudo

RUN apt-get update && apt-get install -y systemctl

# Добавление репозитория Ondřej Surý для PHP и установка PHP 8.3
#RUN add-apt-repository ppa:ondrej/php && apt-get update
# Устанавливаем PHP 8.3
RUN apt-get install -y php8.3 php8.3-fpm php8.3-cli php8.3-mysql libapache2-mod-php8.3 git php8.3-bz2 php8.3-curl php8.3-mbstring php8.3-intl php8.3-zip php8.3-xml php8.3-gd

# Установка Apache
RUN apt-get install -y apache2 libapache2-mod-php8.3
# Конфигурируем Apache
RUN a2enmod rewrite headers

#  Конфигурируем Nginx
RUN apt-get install -y nginx \
    && systemctl enable nginx
#    && systemctl start nginx

# Настройка конфигураций PHP для работы через FPM и Apache
RUN sed -i 's/listen = \/run\/php\/php8.3-fpm.sock/listen = 9000/' /etc/php/8.3/fpm/pool.d/www.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Копирование настроенного виртуального хоста для Apache и Nginx
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
COPY ./nginx.conf /etc/nginx/sites-available/default

# Открытие портов для Apache и Nginx
EXPOSE 80 443

# Отключение стандартного сайта в Nginx и запуск PHP-FPM, Apache и Nginx
CMD service php8.3-fpm start && a2enmod php8.3 && service apache2 restart && tail -F /var/log/nginx/access.log /var/log/nginx/error.log

# Копируем файлы в контейнер
#COPY . /home/user/services/

### Apache конфигурация виртуального хоста для "metrika.loc"
### Создаем файл конфигурации в /etc/apache2/sites-available/
#COPY /home/user/services/apache.conf /etc/apache2/sites-available/metrika.loc.conf
### Включаем виртуальный хост
#RUN a2ensite metrika.loc.conf
### Перезапуск Apache
#RUN systemctl restart apache2
##
### Nginx конфигурация
##COPY /home/user/services/nginx.conf /etc/nginx/conf.d/metrika.loc.conf
##RUN ln -s /etc/nginx/conf.d/metrika.loc.conf /etc/nginx/sites-enabled/
#
## Устанавливаем composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#ENV COMPOSER_ALLOW_SUPERUSER=1
##RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#
#CMD ["php-fpm", "--nodaemonize"]
#
## Устанавливаем зависимости composer
##WORKDIR /home/user/services/metrika.loc
##RUN composer install --no-dev
#
##RUN chmod +x /home/user/services/etc/ubuntu/start.sh
## Запускаем сервер при старте контейнера
##CMD chmod +x /home/user/services/etc/ubuntu/start.sh
##CMD /home/user/services/etc/ubuntu/start.sh