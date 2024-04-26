# Immagine Ubuntu ufficiale come base
FROM ubuntu:latest

# Aggiorna i repository e installa gli strumenti
RUN apt-get update && \
    apt-get install -y \
    nmap \
    tcpdump \
    iproute2 \
    iputils-ping \
    curl \
    && apt-get clean

# Imposta l'ambiente di lavoro predefinito
WORKDIR /root

# Lascia il container in esecuzione
CMD ["tail", "-f", "/dev/null"]
