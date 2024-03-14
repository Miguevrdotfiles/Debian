#!/bin/bash

# Añadirte a sudoers /etc/sudoers
# Instalar sudo

sudo apt update
sudo apt upgrade -y
sudo apt remove gnome-games gnome-weather calendar libreoffice-gnome libreoffice-common gnome-contacts gnome-mahjongg gnome-maps gnome-klotski gnome-mines gnome-robots gnome-sudoku -y
sudo apt install git ssh zsh curl gcc gnuplot snapd make cmake g++ openjdk-17-jdk texlive-full -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo snap install core
sudo snap install snap-store
sudo snap install code --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install clion --classic
sudo snap install spotify
sudo snap install telegram-desktop
sudo snap install nvim --classic
sudo apt autoremove -y
sudo apt autoclean -y
cd ~/Downloads/
rm -r *
wget https://download1334.mediafire.com/zjmq5a1uijmgaekInjgQu8NxU-gi5cfDNB8cHP4BBKCFrgNRlKrhMfK7l17Gy-lvuMW__35ppQo-bmnKobWbHgMq9BkOWEgYTsbRFsxv8Au6B5eAPJELSW-DZP633DuSOBWmI6S_p84kCK7lBqVIR9HiBbeuGqiHd6h654DH8hX0Yt0/uge25hm4m23xm3y/kora.zip
mkdir iconos
unzip * -d ./iconos
wget https://download1979.mediafire.com/tdwv4tzradfgToMmOL8l4l2BXq90nXeschiw4J8hMUh8JpJnbRLjLFDh-s-vcpPM_N3hJU3epArdIlkCvM9sallR3CemwGEwF8JB_iEGsiV6JILmol954Q1CWY2FGaXhow5XTivA0ljXzTRdAnWwlPn8y-9wAAG1oehaJxpOmOyz30U/aa4law5ji37lb92/Orchis-Dark-Compact.zip
mkdir themes
unzip * -d ./themes
cd ./iconos
sudo mv * /usr/share/icons
rm -r *
cd ../
cd ./themes
sudo mv * /usr/share/themes
rm -r *
cd ../
reboot

# Despues de esto puedes meterte en tweaks y elegir en icons kora
# Despues instalar gnome shell extensions (User themes, dash to dock, coverflow alt-tab, etc)
# Recomiendo mucho el tema Orchis gtk theme -> Se descarga y se mueve 
# Orchis dark compact a la carpeta /usr/share/themes
