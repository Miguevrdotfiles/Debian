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

wget https://cdn.insynchq.com/builds/linux/insync_3.8.7.50516-bookworm_amd64.deb
sudo dpkg -i insync_3.8.7.50516-bookworm_amd64.deb

wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/5c3e652f63e798a5ac2f31ffd0d863669328dc4c/code_1.88.0-1712152114_amd64.deb
sudo dpkg -i code_1.88.0-1712152114_amd64.deb

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/powerlevel10k
echo 'source ~/.oh-my-zsh/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# ------------------ Instalacion de programas Flatpak -------------------------#

sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.neovim.nvim






sudo apt autoremove -y
sudo apt autoclean -y

cd ~/Downloads
git clone https://github.com/Miguevrdotfiles/Debian
cd Debian
unzip kora.zip
unzip Orchis-Dark-Compact.zip
sudo mv kora /usr/share/icons
sudo mv Orchis-Dark-Compact /usr/share/themes
sudo mkdir ~/.local/share/fonts/
sudo mv CascadiaCode.ttf ~/.local/share/fonts
sudo mv CaskaydiaCoveNerdFontMono-SemiBold.ttf ~/.local/share/fonts
sudo reboot

# Despues de esto puedes meterte en tweaks y elegir en icons kora
# Despues instalar gnome shell extensions (User themes, dash to dock, coverflow alt-tab, etc)
# Shell Orchis theme tambien en Tweaks
