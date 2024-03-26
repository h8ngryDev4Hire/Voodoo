#!/bin/bash

# Set the repository URL and the desired installation directory
REPO_URL="https://github.com/h8ngryDev4Hire/Voodoo"
INSTALL_DIR="$HOME/.local/bin"
TEMP=".temp"

# Greeting

echo "vooDOO! Your Todo Task Manager | It's Not Magic, It's vooDOO!"

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Either Python is not installed on your system or"
    echo "your system has an outdated version of Python installed."
    echo "Please visit the official Python website to download and install Python:"
    echo "https://www.python.org/downloads/"
    exit 1
fi

# Check if the program is already installed
if [ -f "$INSTALL_DIR/voodoo" ]; then
    echo "The program is already installed."
    read -p "Do you want to overwrite the existing installation? [y/n]: " choice
    case "$choice" in
        y|Y)
            echo "Overwriting the existing installation..."
            ;;
        *)
            echo "Installation aborted."
            exit 0
            ;;
    esac
fi

# Clone the repository
git clone $REPO_URL $TEMP 

# Navigate to the cloned repository directory
cd $TEMP

# Create the installation directory if it doesn't exist
mkdir -p $INSTALL_DIR

# Move the Python script to the installation directory
mv voodoo.py $INSTALL_DIR/voodoo

# Clean up the temporary repository directory
cd ..
rm -rf $TEMP

# Make the installed script executable
chmod +x $INSTALL_DIR/voodoo

# Add the installation directory to PATH if not already present
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$HOME/.bashrc"
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$HOME/.zshrc"
    source "$HOME/.bashrc"
    source "$HOME/.zshrc"
fi

echo "Installation completed successfully!"
echo "You can now run the program using the 'voodoo' command."
