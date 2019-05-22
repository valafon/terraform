FROM ubuntu:latest
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apache2 php libapache2-mod-php php-pgsql

CMD /usr/sbin/apache2ctl -D FOREGROUND
