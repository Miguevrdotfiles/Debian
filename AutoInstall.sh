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
    build-essential
    btop
    flatpak
    curl
    gcc
    make
    cmake
    g++
    texlive
    texlive-lang-spanish
    openjdk-17-jdk
    gnuplot
    neofetch
    gnome-software-plugin-flatpak
    neovim
    clang-19
    okular
    clang
)

#------------------- Desinstalación de programas (APT) ------------------- #
lista_programas_a_desinstalar=(
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
    shotwell
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

#-----------------------| Ejecución del script |-------------------------------#


sudo apt update
sudo apt upgrade -y

instalar_programas "${lista_programas[@]}"
desinstalar_programas "${lista_programas_a_desinstalar[@]}"

sudo apt autoremove -y
sudo apt autoclean -y

# ------------------- Instalación de programas (NO APT) -----------------------#

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/powerlevel10k
echo 'source ~/.oh-my-zsh/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install alacritty

# ------------------ Instalacion de programas Flatpak -------------------------#
flatpak install flathub com.spotify.Client

