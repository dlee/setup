#! /bin/bash

apt update
apt -y upgrade
apt -y install software-properties-common

locale-gen en_US.UTF-8

add-apt-repository -y ppa:keithw/mosh
add-apt-repository -y ppa:neovim-ppa/stable
add-apt-repository -y -r ppa:chris-lea/node.js
apt -y update
apt -y install curl git build-essential nodejs npm fasd neovim mosh zsh tmux python-neovim python3-neovim
npm install -g neovim
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
dpkg -i ripgrep_11.0.2_amd64.deb

echo "Changing shell to ZSH"
[ -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
[ ! -f ~/.ssh/id_rsa.pub ] && cat /dev/zero | ssh-keygen -q -N ""
unset GITHUB_OTP
read -p "Enter Github OTP: " GITHUB_OTP
echo "Uploading Github SSH Key"
curl -u "dlee" \
    --header "x-github-otp: $GITHUB_OTP" \
    --data "{\"title\":\"`hostname`_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
    https://api.github.com/user/keys
cd ~
git clone git@github.com:dlee/dotfiles
cd dotfiles
echo "Running make in dotfiles"
make
