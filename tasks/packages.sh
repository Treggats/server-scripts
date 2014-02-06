#!/usr/bin/env bash

echo "Adding packages"
for pkg in $(cat packages.txt); do pacman -Sp --noprogressbar --noconfirm $pkg; done
