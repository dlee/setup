#! /bin/bash
UCF_FORCE_CONFOLD=1 DEBIAN_FRONTEND=noninteractive
APT='apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -qq -y'
$APT update
$APT upgrade
$APT install software-properties-common
add-apt-repository -y ppa:keithw/mosh
add-apt-repository -y ppa:neovim-ppa/stable
add-apt-repository -y -r ppa:chris-lea/node.js
$APT update
$APT install curl git build-essential nodejs fasd neovim mosh zsh tmux
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
dpkg -i ripgrep_11.0.2_amd64.deb
echo "Changing shell to ZSH"
[ ! -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
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
