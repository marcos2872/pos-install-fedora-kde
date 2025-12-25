#!/bin/bash
if [ -d "os-mcp" ]; then rm -rf os-mcp; fi
git clone https://github.com/marcos2872/os-mcp.git
cd os-mcp
chmod +x install.sh
./install.sh
cd ..
sudo rm -rf os-mcp
