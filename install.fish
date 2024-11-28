#!/usr/bin/fish 

cd ~

if ! type -q git
    echo "You need git installed"
    return 69
end

# Setup general dotfiles
mkdir ~/.dotfiles
cd ~/.dotfiles/
git init --bare
git remote add origin https://github.com/Drawserqzez/dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin main --force
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout main --force

git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showuntrackedfiles no


cd ~

if ! type -q curl
    echo "Need curl to setup fisher"
    return 69
end

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update

fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp
