# Immagine di Kali Linux ufficiale
FROM kalilinux/kali-rolling

# Aggiorna i repository e installa gli strumenti
RUN apt-get update && \
    apt-get install -y \
    nmap \
    tcpdump \
    iproute2 \
    iputils-ping \
    curl \
    hping3 \
    metasploit-framework \
    thc-ssl-dos \
    && apt-get clean

# Imposta l'ambiente di lavoro predefinito
WORKDIR /root

# Mantenere il container in esecuzione
CMD ["tail", "-f", "/dev/null"]
