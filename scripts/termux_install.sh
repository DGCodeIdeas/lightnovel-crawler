#!/bin/bash
#
# Script to install lncrawl on Termux
#

# Exit on error
set -e

echo "Starting lncrawl installation for Termux..."

# 1. Update and upgrade packages
echo "Updating and upgrading packages..."
pkg update -y
pkg upgrade -y

# 2. Install required system dependencies
echo "Installing system dependencies..."
pkg install -y python git libjpeg-turbo libxslt clang

# The README mentions these, but let's ensure they are installed
# via pip with the rest of the dependencies, after installing
# their build dependencies.
# pkg install -y python-grpcio python-lxml python-pillow

# 3. Clone the repository
if [ -d "lightnovel-crawler" ]; then
    echo "lightnovel-crawler directory already exists. Skipping clone."
else
    echo "Cloning lightnovel-crawler repository..."
    git clone https://github.com/dipu-bd/lightnovel-crawler.git
fi

cd lightnovel-crawler

# 4. Install Python dependencies
echo "Installing Python dependencies..."
export CFLAGS="-Wno-error=incompatible-function-pointer-types"
pip install --no-cache-dir -U pip setuptools wheel
pip install --no-cache-dir -r requirements.txt

# 5. Final instructions
echo ""
echo "lncrawl has been installed successfully!"
echo "You can now run it by typing 'lncrawl'."
echo ""
echo "To run it from any directory, you might need to add the script to your PATH."
echo "You can do this by adding the following line to your ~/.bashrc or ~/.zshrc file:"
echo 'export PATH="$HOME/.local/bin:$PATH"'
echo "Then, restart your shell or run 'source ~/.bashrc' or 'source ~/.zshrc'."
