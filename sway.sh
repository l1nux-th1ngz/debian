#!/bin/sh

# Install nala and additional package
sudo apt update
sudo apt install nala -y
sudo nala install --no-install-recommends sddm -y
sudo nala install sudo wget git curl zsh apt-transport-https software-properties-common gpg lsb-release ca-certificates -y
sudo usermod -aG sudo $USER

# Add Brave repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Add PHP Surya repo
echo "deb https://packages.sury.org/php/ bookworm main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -

# Add Visual Studio Code repo
sudo cp -aR vscode.list /etc/apt/sources.list.d/
sudo cp -aR microsoft.gpg /etc/apt/trusted.gpg.d/

# Upgrade 
sudo nala upgrade -y

# Install Sway
sudo nala install sway pavucontrol waybar swaylock sway-backgrounds swayidle grim wl-clipboard rofi xwayland dunst xdg-desktop-portal-wlr qtwayland5 libnm-dev network-manager-gnome slurp -y
sudo nala install nemo btop neofetch network-manager-openvpn-gnome geany geany-plugins alacritty kitty viewnior vlc ranger nemo-fileroller lxappearance mpd mpc ncmpcpp python3-pip -y
pip3 install i3ipc

# Install Package for web dev
sudo nala install code composer nginx network-manager libnss3-tools jq xsel php8.1-cli php8.1-curl php8.1-mbstring php8.1-mcrypt php8.1-xml php8.1-zip php8.1-sqlite3 php8.1-mysql php8.1-pgsql php8.1-fpm -y

# Install polkit-kde-agent
sudo apt install polkit-kde-agent -y

# Install Theme, Icon and Font
sudo nala install papirus-icon-theme fonts-noto-color-emoji -y
sudo git clone https://github.com/EliverLara/Nordic.git /usr/share/themes/Nordic

# Remove unused package
sudo nala purge foot zutty -y

# Copy config file
mkdir -p ~/.config
mkdir -p ~/Pictures
cp -aR dotfiles/config/* ~/.config
cp dotfiles/config/.gtkrc-2.0 ~/
cp -aR dotfiles/backgrounds ~/Pictures
touch ~/.config/mpd/database
mkdir -p ~/.local/share/fonts
cp -aR dotfiles/fonts ~/.local/share
sudo cp -aR dotfiles/extra /usr/share
sudo cp -aR main.py /usr/bin
sudo ln -s /usr/bin/main.py /usr/bin/autotiling
sudo chmod +x /usr/bin/main.py /usr/bin/autotiling
fc-cache -vf

# Finish
systemctl enable --user mpd
sudo nala upgrade -y && sudo nala install jq

