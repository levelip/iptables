
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
 
    IPT="/sbin/iptables"
    $IPT --delete-chain
    $IPT --flush
    
    $IPT -t nat -F
    $IPT -t nat -X
    $IPT -t nat -P PREROUTING ACCEPT
    $IPT -t nat -P POSTROUTING ACCEPT
    $IPT -t nat -P OUTPUT ACCEPT
    $IPT -t mangle -F
    $IPT -t mangle -X
    $IPT -t mangle -P PREROUTING ACCEPT
    $IPT -t mangle -P INPUT ACCEPT
    $IPT -t mangle -P FORWARD ACCEPT
    $IPT -t mangle -P OUTPUT ACCEPT
    $IPT -t mangle -P POSTROUTING ACCEPT
    $IPT -F
    $IPT -X
    $IPT -P FORWARD ACCEPT
    $IPT -P INPUT ACCEPT
    $IPT -P OUTPUT ACCEPT
    $IPT -t raw -F
    $IPT -t raw -X
    $IPT -t raw -P PREROUTING ACCEPT
    $IPT -t raw -P OUTPUT ACCEPT
 
    #Default Policy
    $IPT -P INPUT DROP   
    $IPT -P FORWARD DROP
    $IPT -P OUTPUT DROP
     
    #INPUT Chain
    $IPT -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    $IPT -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
    $IPT -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
    $IPT -A OUTPUT -o ${PUB_IF} -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
    $IPT -A INPUT -i ${PUB_IF} -p udp --sport 123 -m state --state ESTABLISHED -j ACCEPT
    
    $IPT -A OUTPUT -o ${PUB_IF} -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
    $IPT -A INPUT -i ${PUB_IF} -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT
    
    $IPT -A INPUT -i lo -j ACCEPT
    $IPT -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    $IPT -A INPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT
    $IPT -A INPUT -p tcp --syn -m recent --name portscan --rcheck --seconds 60 --hitcount 10 -j LOG
    $IPT -A INPUT -p tcp --syn -m recent --name portscan --set -j DROP
    #OUTPUT Chain
    $IPT -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    $IPT -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
    $IPT -A OUTPUT -o lo -j ACCEPT
    $IPT -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    $IPT -A OUTPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT

    $IPT -t nat -A POSTROUTING -s 172.16.36.0/24 -j SNAT --to-source 192.81.129.64
    $IPT -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    $IPT -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT
    $IPT -A INPUT -i eth0 -p gre -j ACCEPT
    $IPT -A FORWARD -i ppp+ -o eth0 -j ACCEPT
    $IPT -A FORWARD -i eth0 -o ppp+ -j ACCEPT
    $IPT -A OUTPUT -p tcp --dport 1723 -j ACCEPT
    $IPT -A OUTPUT -p gre -j ACCEPT     
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

iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source 74.207.241.17
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
 
