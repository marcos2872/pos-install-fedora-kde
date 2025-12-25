#!/bin/bash
sudo dnf install -y rpm-build
if [ -d "claude-desktop-fedora" ]; then rm -rf claude-desktop-fedora; fi
git clone https://github.com/marcos2872/claude-desktop-fedora.git
cd claude-desktop-fedora
echo "Construindo pacote Claude Desktop..."
sudo ./build-fedora.sh
echo "Instalando..."
RPM_FILE=$(ls build/electron-app/$(uname -m)/claude-desktop-*.rpm | head -n 1)
if [ -f "$RPM_FILE" ]; then
    sudo dnf install -y "$RPM_FILE"
else
    echo "Erro: RPM não encontrado!"
    exit 1
fi
cd ..
sudo rm -rf claude-desktop-fedora
