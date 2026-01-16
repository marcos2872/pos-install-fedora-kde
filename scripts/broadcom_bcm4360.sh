#!/bin/bash

# ==============================================================================
# Broadcom BCM4360 Driver Installation Script
# This script installs the proprietary Broadcom driver for BCM4360 Wi-Fi cards.
# It enables RPM Fusion repositories, installs akmod-wl, sets up module blacklist,
# and removes conflicting modules.
# ==============================================================================

set -e  # Exit on any error

echo "╔════════════════════════════════════════════════════════════╗"
echo "║ Installing Broadcom BCM4360 Driver                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Function to handle errors
handle_error() {
    echo "❌ Error occurred during installation. Exiting."
    exit 1
}

# Trap errors
trap handle_error ERR

# 1) Enable RPM Fusion repositories if not already enabled
echo "📦 Checking and enabling RPM Fusion repositories..."
if ! rpm -q rpmfusion-free-release &> /dev/null; then
    sudo dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo "✅ RPM Fusion repositories enabled."
else
    echo "✅ RPM Fusion repositories already enabled."
fi
echo ""

# 2) Update system and install akmod-wl
echo "🔄 Updating system..."
sudo dnf update -y -q

echo "📦 Installing Broadcom driver (akmod-wl)..."
if ! rpm -q akmod-wl &> /dev/null; then
    sudo dnf install -y akmod-wl
    echo "✅ akmod-wl installed."
else
    echo "✅ akmod-wl already installed."
fi

# Ensure kernel-devel is installed for akmod to build
if ! rpm -q kernel-devel &> /dev/null; then
    echo "📦 Installing kernel-devel..."
    sudo dnf install -y kernel-devel
    echo "✅ kernel-devel installed."
else
    echo "✅ kernel-devel already installed."
fi
echo ""

# 3) Create module blacklist to prevent conflicts
echo "🛡️ Setting up module blacklist..."
sudo tee /etc/modprobe.d/blacklist-broadcom.conf > /dev/null <<'EOF'
blacklist b43
blacklist bcma
blacklist ssb
blacklist brcmfmac
blacklist brcmsmac
EOF
echo "✅ Blacklist created."
echo ""

# 4) Remove conflicting modules if loaded
echo "🧹 Removing conflicting modules..."
sudo modprobe -r b43 bcma ssb brcmfmac brcmsmac 2>/dev/null || true
echo "✅ Conflicting modules removed (if any were loaded)."
echo ""

echo "╔════════════════════════════════════════════════════════════╗"
echo "║ ✅ Broadcom BCM4360 Driver Installation Complete          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Note: You may need to wait for akmods to build the module or reboot to load the wl module."
echo "Check with 'lsmod | grep wl' after reboot."
