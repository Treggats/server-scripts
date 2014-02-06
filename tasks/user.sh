#!/usr/bin/env bash

echo -n "What is the username?"
read user

echo "Add user $user"
useradd -m -G wheel $user

echo "Set password for $user"
passwd $user

echo "Create ssh dir for user $user"
su - $user -c "mkdir ~/.ssh/"

echo "Add pub-key to authenticated_keys"
su - $user -c "touch ~/.ssh/authorized_keys"
su - $user -c "touch ~/.ssh/id_dsa.pub"

echo "ssh-dss AAAAB3NzaC1kc3MAAACBAKWEqd7sVjReCCAEoLmb937y9XoNTEi1dpR7pB7Nln+GkLc3N8La475YmqLoRvkmT2dnyDNHkqdgj9ivEggTgBPC/daoNpAvMXjmjioheWhxyB02QxPlADOyKCuhH4ceGdf7gdh39MEiQwfGYKg2RGwTJJoaz/QUY2IsXvMTSeFhAAAAFQDkiYVZTLSEMa37kLtpz6V17dsCkwAAAIEAjXt8ctABhMAn3od9ubB0FdRk5j1fjtBtI3oVg4WUZ9coNFrmWE+M4LkzEStGr5iJpP9g7UOM2tpCTHpQvBE6SUX8LnaU2014egYPskvsEzV6ZGAUCdBrS1pswBRExSQlb/zkIJZ/sR+qKzbdjADvukuCCH2aCsBWnOmhBCTCAPcAAACAD/gjf31caj7wvrSswbU7xDfB7zyy8xQKUuQfYp/WYnf63LEPbJZNeMbxEq9YfalT6ErM0UbN8/dDIdxs/J5Pwl/z9WuRa771CMRvWVCTEOAN/pmTdwisXJtB9n/6o+MiFdfMFUFCnsMwZKTZNrFuYMkg2K7QF3UmQ3k7zQHhyvY= tonkomulder@iMac-Inobe.local" >> /home/$user/.ssh/authenticated_keys
echo "ssh-dss AAAAB3NzaC1kc3MAAACBAKWEqd7sVjReCCAEoLmb937y9XoNTEi1dpR7pB7Nln+GkLc3N8La475YmqLoRvkmT2dnyDNHkqdgj9ivEggTgBPC/daoNpAvMXjmjioheWhxyB02QxPlADOyKCuhH4ceGdf7gdh39MEiQwfGYKg2RGwTJJoaz/QUY2IsXvMTSeFhAAAAFQDkiYVZTLSEMa37kLtpz6V17dsCkwAAAIEAjXt8ctABhMAn3od9ubB0FdRk5j1fjtBtI3oVg4WUZ9coNFrmWE+M4LkzEStGr5iJpP9g7UOM2tpCTHpQvBE6SUX8LnaU2014egYPskvsEzV6ZGAUCdBrS1pswBRExSQlb/zkIJZ/sR+qKzbdjADvukuCCH2aCsBWnOmhBCTCAPcAAACAD/gjf31caj7wvrSswbU7xDfB7zyy8xQKUuQfYp/WYnf63LEPbJZNeMbxEq9YfalT6ErM0UbN8/dDIdxs/J5Pwl/z9WuRa771CMRvWVCTEOAN/pmTdwisXJtB9n/6o+MiFdfMFUFCnsMwZKTZNrFuYMkg2K7QF3UmQ3k7zQHhyvY= tonkomulder@iMac-Inobe.local" >> /home/$user/.ssh/id_dsa.pub
