#!/usr/bin/env bash

# Prerequisites
# * iTerm
# * oh-my-zsh
# * Installed profiles on iTerm
# * powerlevel9k

cd ~/dotfiles

echo "Adding vimrc"
cp ~/.vimrc ~/dotfiles/vimrc

echo "Adding .gitconfig"
cp ~/.gitconfig ~/dotfiles/gitconfig

echo "Adding personal zshrc"
cp ~/.zshrc-custom ~/dotfiles/zshrc-custom

git add .

echo "What is your update?"
read commit_message

git commit -m "${commit_message}"

git push

echo "Updated"

cd -
