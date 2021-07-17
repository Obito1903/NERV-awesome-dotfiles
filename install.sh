#!/bin/bash


if ! [ -d "backup" ]; then
    mkdir backup
fi

for filename in .config/*; do
    if [ -f "$HOME/$filename" ] || [ -d "$HOME/$filename" ]; then
        cp -r "$HOME/$filename" "backup/$filename"
        rm -rf "$HOME/$filename"
    fi
    ln -s "$(pwd)/$filename" "$HOME/$filename"
done

for file in home/.[!.]* home/*; do
    filename="${file##*/}"
    echo "$filename"
    if [ -f "$HOME/$filename" ] || [ -d "$HOME/$filename" ]; then
        cp -r "$HOME/$filename" "backup/$filename"
        rm -rf "$HOME/$filename"
    fi
    if  [ -f "home/$filename" ] || [ -d "home/$filename" ]; then
        ln -s "$(pwd)/home/$filename" "$HOME/$filename"
    fi
done

echo "Arch ?[y/n]"
read arch
if [ $arch = "y" ]; then
    echo "Installing yay"
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay

    echo "Installing base dotfiles dependency"
    yay -Sy picom-jonaburg-git awesome-git rofi zsh noto-fonts noto-fonts-extra noto-fonts-cjk lsd playerctl alacritty

    echo "configuring Zsh and ohMyZsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Please install softwares listed in the readme"
fi

echo "Use picom with animation ? (may not be compatible on older intel graphics)[y/n]"
read picom
if [ $picom = "y" ]; then
    yay -S picom-jonaburg-git
else
    yay -S picom-ibhagwan-git
fi
