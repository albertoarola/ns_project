FROM ubuntu:latest

# Installa iptables, tcpdump e iproute2
RUN apt-get update \
    && apt-get install -y iptables tcpdump iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copia lo script di configurazione del firewall
COPY firewall-config.sh /usr/local/bin/firewall-config.sh
RUN chmod +x /usr/local/bin/firewall-config.sh

# Avvia lo script di configurazione del firewall e lasciare il container in esecuzione
CMD ["/bin/bash", "-c", "/usr/local/bin/firewall-config.sh && tail -f /dev/null"]
