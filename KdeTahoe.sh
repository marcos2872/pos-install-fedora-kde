#!/bin/bash

echo "╔════════════════════════════════════════════════════════════╗"
echo "║ Transformando Fedora KDE em macOS (MacTahoe Theme)         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Função para pausar e mostrar erros
pause_on_error() {
  if [ $? -ne 0 ]; then
    echo ""
    echo "❌ ERRO ENCONTRADO! Pressione ENTER para continuar..."
    read
  fi
}

# 1. Instalar dependências
echo "📦 Instalando dependências..."
sudo dnf install -y git kvantum kvantum-qt5 sassc 2>&1
pause_on_error
echo "✅ Dependências instaladas!"
echo ""

# 2. Criar pasta temporária e LIMPAR se já existir
if [ -d ~/mactahoe-install-temp ]; then
  echo "🗑️ Limpando pasta anterior..."
  rm -rf ~/mactahoe-install-temp
fi

mkdir -p ~/mactahoe-install-temp
cd ~/mactahoe-install-temp
echo "📁 Pasta criada em: $(pwd)"

# 3. MacTahoe KDE (tema Plasma + Kvantum)
echo ""
echo "🎨 Baixando MacTahoe KDE Theme..."
git clone https://github.com/vinceliuice/MacTahoe-kde.git 2>&1
pause_on_error

cd MacTahoe-kde
echo "⚙️ Instalando MacTahoe KDE..."
bash ./install.sh 2>&1
pause_on_error
cd ..

# 4. MacTahoe Icons
echo ""
echo "🖼️ Baixando MacTahoe Icons..."
git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git 2>&1
pause_on_error

cd MacTahoe-icon-theme
echo "⚙️ Instalando Ícones MacTahoe..."
bash ./install.sh 2>&1
pause_on_error
cd ..

# 5. MacTahoe Cursors
echo ""
echo "🖱️ Baixando MacTahoe Cursors..."
git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git MacTahoe-cursors-src 2>&1
pause_on_error

cd MacTahoe-cursors-src/cursors
echo "⚙️ Instalando Cursores MacTahoe..."
bash ./install.sh 2>&1
pause_on_error
cd ../..

# Limpeza
cd ~
rm -rf ~/mactahoe-install-temp

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║ ✅ INSTALAÇÃO CONCLUÍDA!                                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Abra: Configurações do Sistema → Aparência → Tema Global"
echo "2. Selecione: MacTahoe Light ou MacTahoe Dark"
echo "3. Abra: Kvantum Manager"
echo "4. Selecione MacTahoe → 'Use this theme'"
echo ""
echo "Pressione ENTER para fechar..."
read
