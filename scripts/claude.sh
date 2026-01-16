#!/bin/bash

# ==============================================================================
# Claude Desktop AppImage Installation Script
# This script downloads and installs the Claude Desktop AppImage from the
# aaddrick/claude-desktop-debian repository.
# ==============================================================================

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║ Installing Claude Desktop (AppImage)                      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Function to handle errors
handle_error() {
    echo "❌ Error occurred during installation. Exiting."
    exit 1
}

# Trap errors
trap handle_error ERR

# Determine architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        APPIMAGE_ARCH="amd64"
        ;;
    aarch64)
        APPIMAGE_ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Define paths
APP_DIR="$HOME/Applications"
APPIMAGE_NAME="claude-desktop.AppImage"
APPIMAGE_PATH="$APP_DIR/$APPIMAGE_NAME"

# Create Applications directory if it doesn't exist
if [ ! -d "$APP_DIR" ]; then
    mkdir -p "$APP_DIR"
    echo "📁 Created $APP_DIR"
fi

# Check if AppImage already exists
if [ -f "$APPIMAGE_PATH" ] && [ -x "$APPIMAGE_PATH" ]; then
    echo "✅ Claude Desktop AppImage already installed at $APPIMAGE_PATH"
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║ ✅ Claude Desktop Installation Complete                   ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "You can run it with: $APPIMAGE_PATH"
    exit 0
fi

# Fetch the latest release information and get the download URL
echo "📦 Fetching latest release information..."
LATEST_INFO=$(curl -s https://api.github.com/repos/aaddrick/claude-desktop-debian/releases/latest)
if [ $? -ne 0 ] || [ -z "$LATEST_INFO" ]; then
    echo "❌ Failed to fetch release information."
    exit 1
fi

DOWNLOAD_URL=$(echo "$LATEST_INFO" | grep "browser_download_url.*${APPIMAGE_ARCH}\.AppImage" | head -1 | cut -d '"' -f 4)
if [ -z "$DOWNLOAD_URL" ]; then
    echo "❌ Could not find AppImage download URL for $APPIMAGE_ARCH."
    exit 1
fi

echo "📦 Downloading Claude Desktop AppImage for $APPIMAGE_ARCH..."

if command -v curl &> /dev/null; then
    curl -L -o "$APPIMAGE_PATH" "$DOWNLOAD_URL"
elif command -v wget &> /dev/null; then
    wget -O "$APPIMAGE_PATH" "$DOWNLOAD_URL"
else
    echo "❌ Neither curl nor wget is available. Please install one of them."
    exit 1
fi

# Make executable
chmod +x "$APPIMAGE_PATH"
echo "✅ Downloaded and made executable: $APPIMAGE_PATH"

# Copy local Claude icon
echo "🖼️ Copying Claude icon..."
LOCAL_ICON="../images/claude.png"
ICON_PATH="$APP_DIR/claude-icon.png"
if [ -f "$LOCAL_ICON" ]; then
    cp "$LOCAL_ICON" "$ICON_PATH"
    echo "✅ Icon copied to $ICON_PATH"
else
    echo "⚠️ Warning: Local icon not found at $LOCAL_ICON. Skipping."
    ICON_PATH=""
fi

# Create desktop entry for system integration
echo "🖥️ Creating desktop entry..."
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_DIR/claude.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Claude Desktop
Comment=AI assistant by Anthropic
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Terminal=false
Categories=Utility;AI;
EOF
echo "✅ Desktop entry created at $DESKTOP_DIR/claude.desktop"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║ ✅ Claude Desktop Installation Complete                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "You can run Claude Desktop with: $APPIMAGE_PATH"
echo "It has been added to your applications menu."
echo "For additional integration features, consider using a tool like Gear Lever."
