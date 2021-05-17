#!/usr/bin/env bash

cd ~/dotfiles

echo "Adding vimrc"
cp ~/.vimrc ~/dotfiles/vimrc

echo "Adding .gitconfig"
cp ~/.gitconfig ~/dotfiles/gitconfig

git add .

echo "What is your update?"
read commit_message

git commit -m "${commit_message}"

git push

echo "Updated"
