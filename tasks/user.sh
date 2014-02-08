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

if [ -f ~/.ssh/id_*sa.pub ]; then
    cat ~/.ssh/id_*sa.pub > /home/$user/.ssh/authenticated_keys
    cat ~/.ssh/id_*sa.pub > /home/$user/.ssh/id_dsa.pub
else
    echo -n "No ssh keys found, please enter a public key"
    read key
    echo $key > /home/$user/.ssh/authenticated_keys
    echo $key > /home/$user/.ssh/id_dsa.pub
fi
