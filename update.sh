#!/usr/bin/env bash

cd ~/dotfiles

cp -u ~/.vimrc ~/dotfiles/vimrc

git add .

echo "What is your vimrc update?"
read commit_message

git commit -m "${commit_message}"

git push

echo "Updated"

read ok
