
    iptables -X
    iptables -P FORWARD ACCEPT
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -t raw -F
    iptables -t raw -X
    iptables -t raw -P PREROUTING ACCEPT
    iptables -t raw -P OUTPUT ACCEPT

/sbin/iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --update --seconds 60  --hitcount 15 -j DROp
service iptables save
 
    
  

    #iptables save
    service iptables save
    service iptables restart
 
    iptables --delete-chain
    iptables --flush
    
    iptables -t nat -F
    iptables -t nat -X
    iptables -t nat -P PREROUTING ACCEPT
    iptables -t nat -P POSTROUTING ACCEPT
    iptables -t nat -P OUTPUT ACCEPT
    iptables -t mangle -F
    iptables -t mangle -X
    iptables -t mangle -P PREROUTING ACCEPT
    iptables -t mangle -P INPUT ACCEPT
    iptables -t mangle -P FORWARD ACCEPT
    iptables -t mangle -P OUTPUT ACCEPT
    iptables -t mangle -P POSTROUTING ACCEPT
    iptables -F
    iptables -X
    iptables -P FORWARD ACCEPT
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -t raw -F
    iptables -t raw -X
    iptables -t raw -P PREROUTING ACCEPT
    iptables -t raw -P OUTPUT ACCEPT
 
    #Default Policy
    iptables -P INPUT DROP   
    iptables -P FORWARD DROP
    iptables -P OUTPUT DROP
     
    #INPUT Chain
    iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
    iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
    
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    iptables -A INPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT
    iptables -A INPUT -p tcp --syn -m recent --name portscan --rcheck --seconds 60 --hitcount 10 -j LOG
    iptables -A INPUT -p tcp --syn -m recent --name portscan --set -j DROP
    #OUTPUT Chain
    iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
    iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    iptables -A OUTPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT

iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source  `ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk 'NR==1 { print $1}'`
    iptables -A FORWARD -p tcp --syn -s 192.168.0.0/24 -j TCPMSS --set-mss 1356
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT
    iptables -A INPUT -i eth0 -p gre -j ACCEPT
    iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT
    iptables -A FORWARD -i eth0 -o ppp+ -j ACCEPT
    iptables -A OUTPUT -p tcp --dport 1723 -j ACCEPT
    iptables -A OUTPUT -p gre -j ACCEPT     
    #iptables save
    service iptables save
    service iptables restart

iptables -L -n -t nat
 
