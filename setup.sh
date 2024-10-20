#!/bin/bash

USER="${whoami}"

install_share() {
  if ! command -v git 2>&1 >/dev/null
  then
    apt install git
  fi
  git config --global user.email "qiuweikang1999@gmail.com"
  git config --global user.name "Boltzmachine"
  git config --global credential.helper store

  git clone https://github.com/Boltzmachine/dotfiles.git
  cp dotfiles/* ./
}

install_with_apt() {
  apt update
  apt install fish
  chsh -s /usr/bin/fish $USER
}

OS="${uname -s}"
case "$OS" in
  Linux*)
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "ID" in
      ubuntu | debian)
      echo "Detected Ubuntu/Debian. Using apt."
      install_with_apt()
    esac
  else
    echo "Unable to detect Linux distribution"
  fi
