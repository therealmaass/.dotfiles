#!/usr/bin/env sh

#Define standard tools to be installed:
tools="zsh neovim vim  tmux ranger stow wget curl git"
toolsprint="# ${tools}     #"
cd ~
which $tools > /dev/null 2>&1

if [ $? != 0 ]; then
    if [ -f /etc/os-release ]; then
        OS=$(cat /etc/os-release | grep "ID_LIKE" | cut -d= -f2)
        echo $OS
        if [ "$OS" = "debian" ]|| [ "$OS" = "ubuntu" ]; then
            echo "##############################################"
            echo "# Installing standard tools:                 #"
            echo "$toolsprint"
            echo "##############################################"
            sudo apt-get update && sudo apt-get install -y $tools 
            sleep 3
            echo "##############################################"
            echo "# Install standard tools done!               #"
            echo "##############################################"
            sleep 3
            echo "##############################################"
            echo "# Installing Oh-my-zsh & P10K                #"
            echo "##############################################"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            #Install zsh-syntax-highlighting and zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            echo "###############################################"
            echo "# Install Oh-my-zsh & P10K done!             #"
            echo "###############################################"
        elif [ "$OS" = "arch" ]; then
            echo "THIS IS ARCH"
            echo "##############################################"
            echo "# Installing standard tools:                 #"
            echo "$toolsprint"
            echo "##############################################"
            sleep 3
            echo "##############################################"
            sudo pacman -Syy && sudo pacman -S --noconfirm $tools
            echo "##############################################"
            echo "# Install standard tools done!               #"
            echo "##############################################"
            sleep 3
            echo "##############################################"
            echo "# Installing Oh-my-zsh & P10K                #"
            echo "##############################################"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            #Install zsh-syntax-highlighting and zsh-autosuggestions
            git clone git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            echo "###############################################"
            echo "# Install Oh-my-zsh & P10K done!             #"
            echo "###############################################"
        else
            echo "JAAA"
        fi
    fi
else
    echo "###############################################"
    echo "# Nothing to do all tools are installed! :    #"
    echo "###############################################"
    which $tools
fi

if [[ ! -e ~/.cache/zsh/history ]] && [[ ! -d ~/.cache ]]; then
    mkdir -p ~/.cache/zsh
    touch ~/.cache/zsh/history
fi
