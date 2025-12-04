#!/bin/bash

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Transformando Fedora KDE em macOS (WhiteSur Theme)       ║"
echo "╚════════════════════════════════════════════════════════════╝"

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
if [ -d ~/macos-install-temp ]; then
    echo "🗑️  Limpando pasta anterior..."
    rm -rf ~/macos-install-temp
fi

mkdir -p ~/macos-install-temp
cd ~/macos-install-temp
echo "📁 Pasta criada em: $(pwd)"

# 3. WhiteSur KDE (opção: --sharp em vez de --round)
echo ""
echo "🎨 Baixando WhiteSur KDE Theme..."
git clone https://github.com/vinceliuice/WhiteSur-kde.git 2>&1
pause_on_error

cd WhiteSur-kde
echo "⚙️  Instalando WhiteSur KDE..."
bash ./install.sh  2>&1
pause_on_error
cd ..

# 4. WhiteSur Icons
echo ""
echo "🖼️  Baixando WhiteSur Icons..."
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git 2>&1
pause_on_error

cd WhiteSur-icon-theme
echo "⚙️  Instalando Ícones..."
bash ./install.sh 2>&1
pause_on_error
cd ..

# 5. WhiteSur Cursors
echo ""
echo "🖱️  Baixando WhiteSur Cursors..."
git clone https://github.com/vinceliuice/WhiteSur-cursors.git 2>&1
pause_on_error

cd WhiteSur-cursors
echo "⚙️  Instalando Cursores..."
bash ./install.sh 2>&1
pause_on_error
cd ..

# Limpeza
cd ~
rm -rf ~/macos-install-temp

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  ✅ INSTALAÇÃO CONCLUÍDA!                                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Abra: Configurações do Sistema → Aparência → Tema Global"
echo "2. Selecione: WhiteSur"
echo "3. Abra: Kvantum Manager"
echo "4. Selecione WhiteSur → 'Use this theme'"
echo ""
echo "Pressione ENTER para fechar..."
read
