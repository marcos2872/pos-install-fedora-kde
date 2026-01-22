#!/bin/bash

# ==============================================================================
# Audio Tools Installation Script
# This script installs pavucontrol and easyeffects for audio management.
# ==============================================================================

echo "╔════════════════════════════════════════════════════════════╗"
echo "║ Installing Audio Tools (pavucontrol & easyeffects)        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Install pavucontrol
echo "🔊 Installing pavucontrol..."
if ! rpm -q pavucontrol &> /dev/null; then
    sudo dnf install -y pavucontrol
    echo "✅ pavucontrol installed."
else
    echo "✅ pavucontrol already installed."
fi

echo ""

# Install easyeffects
echo "🎛️ Installing easyeffects..."
if ! rpm -q easyeffects &> /dev/null; then
    sudo dnf install -y easyeffects
    echo "✅ easyeffects installed."
else
    echo "✅ easyeffects already installed."
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║ ✅ Audio Tools Installation Complete                      ║"
echo "╚════════════════════════════════════════════════════════════╝"
