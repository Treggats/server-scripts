#!/bin/sh

HOME='mtonko.xs4all.nl'
case "$1" in

    start)
        iptables --flush
        iptables --table nat --flush
        iptables --delete-chain
        iptables --table nat --delete-chain

        # policy and localhost
        iptables -P INPUT DROP
        iptables -A INPUT -i lo -j ACCEPT
        iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

        # SSH
        iptables -A INPUT -p tcp -s $HOME --destination-port 22 -j ACCEPT

        # MySQL/MariaDB
        iptables -A INPUT -p tcp -s $HOME --destination-port 3306 -j ACCEPT

        # Webserver
        iptables -A INPUT -p tcp --destination-port 80 -j ACCEPT

        # Home
        iptables -A INPUT       -s $HOME -j ACCEPT

        # Block the spammers
        iptables -N SSH_CHECK
        iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j SSH_CHECK
        iptables -A SSH_CHECK -m recent --set --name SSH
        iptables -A SSH_CHECK -m recent --update --seconds 60 --hitcount 4 --name SSH -j DROP

        # LOG the rest
        iptables -A INPUT -j LOG --log-prefix "Firewall dropped: "
        iptables --list -n
        iptables --list -t nat -v
        ;;

   stop)
        iptables -P INPUT ACCEPT
        iptables --flush
        iptables --list -n
        ;;

   restart)
        $0 stop
        $0 start
        ;;

   *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
