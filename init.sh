#!/usr/bin/env bash

if [ whoami != 'root' ]; then
    echo "This script must run with super powers :)"
    exit 1
fi

while :
do
    echo "   Main menu"
    echo "1. Update"
    echo "2. Install packages"
    echo "3. Setup basic firewall"
    echo "4. Enable services"
    echo "5. Add daily update check to crontab"
    echo "6. Add user"
    echo "q. Exit"
    echo -n "Please enter option [1-6]"
    echo ""
    read -n 1 option
    case $option in
        1) echo " Update the system"
            source tasks/update.sh;;
        2) echo " Install packages"
            source tasks/packages.sh;;
        3) echo " Setup basic firewall"
            source tasks/firewall.sh;;
        4) echo " Enable services"
            source tasks/services.sh;;
        5) echo " Add update check to crontab"
            source tasks/crontab.sh;;
        6) echo " Add user"
            source tasks/user.sh ;;
        q) echo " Exit"
            exit 1;;
        *) echo "$option is an invalid option. Please select option [1-6]"
            echo "Press [enter] key to continue";
            read enterKey;;
    esac
    echo ""
done
