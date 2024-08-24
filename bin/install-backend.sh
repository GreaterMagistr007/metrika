if [ "$(docker ps -q -f name=project_server)" ]; then
    # Ставим Apache
    docker exec -it project_server bash -c "apt install apache2 apache2-utils -y"
    docker exec -it project_server bash -c "apt install ufw -y"

    # Ставим nginx
    docker exec -it project_server bash -c "apt install nginx -y"
    docker exec -it project_server bash -c "apt install software-properties-common -y"
    docker exec -it project_server bash -c "add-apt-repository ppa:ondrej/php -y"
    docker exec -it project_server bash -c "apt update -y"
    docker exec -it project_server bash -c "apt install php8.3 -y"
    docker exec -it project_server bash -c "apt install libapache2-mod-php8.3 -y"
    docker exec -it project_server bash -c "apt install php8.3-fpm -y"
    docker exec -it project_server bash -c "apt-get install libapache2-mod-proxy-html"
    docker exec -it project_server bash -c "apt-get install php-xml -y"
    docker exec -it project_server bash -c "apt-get install php-curl -y"
    docker exec -it project_server bash -c "a2enmod proxy"
    docker exec -it project_server bash -c "a2enmod proxy_http"

    # копируем конфиги для apache
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/apache/ports.conf /etc/apache2/ports.conf"
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/apache/apache2.conf /etc/apache2/apache2.conf"
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/apache/sites-available/metrika.conf /etc/apache2/sites-available/metrika.conf"
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/apache/sites-available/site.conf /etc/apache2/sites-available/site.conf"
    docker exec -it project_server bash -c "a2ensite metrika.conf"

    # копируем конфиги для nginx
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/nginx/sites-available/metrika.loc /etc/nginx/conf.d/metrika.conf"
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/nginx/sites-available/metrika.loc /etc/nginx/sites-available/metrika.loc"
    docker exec -it project_server bash -c "cp /home/user/services/etc/ubuntu/nginx/sites-available/metrika.loc /etc/nginx/sites-enabled/metrika.loc"


    # Перезапустим apache и nginx
    docker exec -it project_server bash -c "service nginx restart"
    docker exec -it project_server bash -c "service apache2 restart"

    # Ставим Composer
    docker exec -it project_server bash -c "apt install php-cli unzip -y"
    docker exec -it project_server bash -c "curl -sS https://getcomposer.org/installer -o composer-setup.php"
    docker exec -it project_server bash -c "php composer-setup.php --install-dir=/usr/local/bin --filename=composer"



    echo "Скрипт успешно отработал и понаставил всякой херни в контейнеры"
    sleep
    pause
else
    echo "Для работы скрипта нужно запустить Docker-контейнер project_server!"
    sleep
    pause
fi;
sleep
pause