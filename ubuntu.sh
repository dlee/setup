#! /bin/bash
apt update
apt upgrade -y
apt install -y software-properties-common
add-apt-repository -y ppa:keithw/mosh
add-apt-repository -y ppa:neovim-ppa/stable
add-apt-repository -y -r ppa:chris-lea/node.js
apt update
apt install -y curl git build-essential nodejs fasd neovim mosh zsh tmux
chsh -s /usr/bin/zsh
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
dpkg -i ripgrep_11.0.2_amd64.deb
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
cat /dev/zero | ssh-keygen -q -N ""
read -p "Enter Github OTP: " OTP
echo "Uploading Github SSH Key"
curl -u "dlee" \
    --header "x-github-otp: $OTP" \
    --data "{\"title\":\"`hostname`_`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
    https://api.github.com/user/keys
