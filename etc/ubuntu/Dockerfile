FROM ubuntu:24.10
# Планируем выполнять последующие команды под рутом
USER root
# Обновляемся
RUN apt update -y
RUN apt upgrade -y
# Apache
RUN apt install curl gnupg2 ca-certificates lsb-release -y
RUN apt install apache2 apache2-utils -y
# Файрволл (открываем только 80 и 443 порты)
RUN apt install ufw -y
RUN ufw allow 80
RUN ufw allow 443