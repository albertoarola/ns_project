#!/bin/bash

# Pulisce tutte le regole iptables esistenti
iptables -F
iptables -X

# Politica predefinita: blocca tutto il traffico in ingresso e permette tutto il traffico in uscita
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Abilita il forwarding del traffico IPv4
echo 1 > /proc/sys/net/ipv4/ip_forward

# Crea una nuova catena chiamata "RATE_LIMIT" per gestire il rate limiting
iptables -N RATE_LIMIT

# Imposta un limite di 10 pacchetti al secondo per il traffico in ingresso
iptables -A RATE_LIMIT -m hashlimit --hashlimit 10/s --hashlimit-mode srcip --hashlimit-name conn_rate_limit -j ACCEPT

# Se superato il limite, i pacchetti vengono droppati
iptables -A RATE_LIMIT -j DROP

# Imposta un limite di 10 connessioni TCP contemporanee per ogni host che tenta di connettersi al server
iptables -A FORWARD -p tcp -d 172.20.0.3 --dport 80 -m conntrack --ctstate NEW -m connlimit --connlimit-above 10 --connlimit-mask 32 -j DROP

# Consentire il forwarding del traffico HTTP e HTTPS tra il server web e il mondo esterno
# Inoltre il server potrà solo rispondere e non iniziare una nuova connessione

iptables -A FORWARD -i eth0 -p tcp --syn -d 172.20.0.3 --dport 80 -m state --state NEW -j RATE_LIMIT

iptables -A FORWARD -i eth0 -p tcp -d 172.20.0.3 --dport 80 -m state --state ESTABLISHED -j ACCEPT

iptables -A FORWARD -i eth1 -p tcp -s 172.20.0.3 --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -i eth0 -p tcp --syn -d 172.20.0.3 --dport 443 -m state --state NEW -j RATE_LIMIT

iptables -A FORWARD -i eth0 -p tcp -d 172.20.0.3 --dport 443 -m state --state ESTABLISHED -j ACCEPT

iptables -A FORWARD -i eth1 -p tcp -s 172.20.0.3 --sport 443 -m state --state RELATED,ESTABLISHED -j ACCEPT





