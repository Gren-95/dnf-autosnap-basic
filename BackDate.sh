#!/bin/bash

# Backup
sudo timeshift --create --comments "Autoup backup $(date +%m/%d)" --tags D | awk ' /Snapshot|Tagged/ { print }'
# DNF
sudo dnf update -y | awk '(NR>1)'
sudo dnf autoremove -y | awk '(NR>1)'

# Flatpak
flatpak update -y | awk '(NR>1)'
flatpak remove --unused -y | awk '(NR>1)'

read -p "Do you want to reboot for all the updates to take effect? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    reboot
else
  exit
fi
