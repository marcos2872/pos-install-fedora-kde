#!/bin/bash

sudo dnf install -y -q flatpak 
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
source ~/.bashrc
