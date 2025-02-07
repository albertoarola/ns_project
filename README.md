# **Project: Firewall developed with iptables**

This project sets up two Docker subnets: one containing a **web server** and the other containing an **attacker**. Both subnets are connected via a **firewall**, which acts as the **default gateway**, and is configured using **iptables**. The firewall rules are designed to prevent **TCP SYN Flood** and **Slowloris** attacks from the attacker.

## Architecture

The project is structured into two Docker subnets:

1. **Web Server Subnet**:
   - Contains a web server, which could be an application like Apache, Nginx, or any other web server.
   - The subnet simulates a production environment.
   
2. **Attacker Subnet**:
   - Contains a container that simulates an attacker.
   - The attacker attempts **TCP SYN Flood** and **Slowloris** attacks.

3. **Firewall (Default Gateway)**:
   - A container that acts as the **default gateway** for both subnets.
   - Uses **iptables** to enforce firewall rules.
   - The rules include:
     - Protection against **TCP SYN Flood** attacks.
     - Protection against **Slowloris** attacks.
