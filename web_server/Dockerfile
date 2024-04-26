# Usa un'immagine base di Ubuntu
FROM ubuntu:latest

# Installa Apache e SSL
RUN apt-get update \
    && apt-get install -y apache2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installa strumenti per la gestione di rete
RUN apt-get update \
    && apt-get install -y iproute2 tcpdump iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Abilita i moduli Apache necessari
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod headers

# Copia i file di configurazione Apache
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Genera una chiave privata e un certificato autofirmato per SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Abilita il sito HTTPS
RUN a2ensite default-ssl

# Esponi le porte 80 e 443
EXPOSE 80
EXPOSE 443

# Avvia Apache in primo piano
CMD ["apache2ctl", "-D", "FOREGROUND"]
