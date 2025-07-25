#!/bin/bash

# Check if .env file exists
if [ ! -f .env ]; then
    # If not, copy the template
    cp .env.template .env
    echo ".env file created from template."
fi

# Install dependencies
echo "Installing dependencies..."
npm install

# Make the CLI available globally
echo "Making the CLI available globally..."
npm link

echo "Installation complete. You can now use the 'Cliode' command."