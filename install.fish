#!/usr/bin/fish 

cd ~

if ! test (git --version)
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

