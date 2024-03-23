#!/bin/bash

# Esto es un script para instalar Debian de una manera comoda, el autor es Miguevrgo
# Para ello, en primer lugar deberemos asegurar que estamos en la cuenta de usuario,
# con privilegios para ejecutar comandos con sudo.
#
# Para realizar esto:
# $ su 
# $ vi/nano/[editor de preferencia] /etc/sudoers
# $ añadir junto a root el usuario con todos los permisos que se quieran tener (ALL esta bien)
#
# En un futuro, intentare sacar una distribución de Debian que ya venga con todos los programas
# para uso personal o de gente interesada.



# ------------------- Instalación de programas (APT) ------------------- #
lista_programas=(
    git
    ssh
    zsh
    curl
    gcc
    make
    cmake
    g++
    texlive-full
    openjdk-17-jdk
    gnuplot
    neofetch
    neovim
    okular
)

#------------------- Desinstalación de programas (APT) ------------------- #
lista_programamas_a_desinstalar=(
    gnome-games
    gnome-weather
    calendar
    libreoffice-gnome
    libreoffice-common
    gnome-contacts
    gnome-mahjongg
    gnome-maps
    gnome-klotski
    gnome-mines
    gnome-robots
    gnome-sudoku
    evolution
    kdeconnect
    cheese
    evince
)

# ------------------- Funciones Auxiliares ------------------- #

function instalar_programas() {
    local programas=("$@")
    local total=${#programas[@]}
    local actual=0

    for programa in "${programas[@]}"; do
        ((actual++))
        sudo apt install -y "$programa" &> /dev/null || {
        echo "Error instalando $programa."
        return 1
        }
        porcentaje=$((actual * 100 / total))
        if [[ $actual -eq $total ]]; then
        tput cuf $(tput cols)   
        echo -ne "$porcentaje% completado.\n"
        fi
    done
}


function desinstalar_programas() {
    local programas=("$@")
    local total=${#programas[@]}
    local actual=0
    for programa in "${programas[@]}"; do
        ((actual++))
        sudo apt remove -y "$programa" &> /dev/null || {
        echo "Error desinstalando $programa."
        return 1
        }
        porcentaje=$((actual * 100 / total))
        if [[ $actual -eq $total ]]; then
        tput cuf $(tput cols)   
        echo -ne "$porcentaje% completado.\n"
        fi
    done
}

# ------------------- Ejecución del script ------------------- #


sudo apt update
sudo apt upgrade -y

instalar_programas "${lista_programas[@]}"
desinstalar_programas "${lista_programas_a_desinstalar[@]}"

sudo apt autoremove -y
sudo apt autoclean -y

# ------------------- Instalación de programas (NO APT) ------------------- #

wget https://cdn.insynchq.com/builds/linux/insync_3.8.7.50516-bookworm_amd64.deb
sudo dpkg -i insync_3.8.7.50516-bookworm_amd64.deb

wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/863d2581ecda6849923a2118d93a088b0745d9d6/code_1.87.2-1709912201_amd64.deb
sudo dpkg -i code_1.87.2-1709912201_amd64.deb
#clion
# ./install.sh --bin /usr/bin/idea --desktop-file /usr/share/applications/jetbrains-idea.desktop --create-package /tmp/jetbrains-idea.deb

curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update -y && sudo apt-get install spotify-client -y
sudo apt autoremove -y
sudo apt autoclean -y

cd ~/Downloads
git clone https://github.com/Miguevrdotfiles/Debian
cd Debian
unzip kora.zip
unzip Orchis-Dark-Compact.zip
sudo mv kora /usr/share/icons
sudo mv Orchis-Dark-Compact /usr/share/themes
sudo mv CascadiaCode.ttf ~/.local/share/fonts
sudo mv CaskaydiaCoveNerdFontMono-SemiBold.ttf ~/.local/share/fonts
sudo reboot

# Despues de esto puedes meterte en tweaks y elegir en icons kora
# Despues instalar gnome shell extensions (User themes, dash to dock, coverflow alt-tab, etc)
# Recomiendo mucho el tema Orchis gtk theme -> Se descarga y se mueve 
# Orchis dark compact a la carpeta /usr/share/themes
