#!/bin/bash

set -eu

SCRIPT_URL="https://raw.githubusercontent.com/ubermanu/sudoas/main/sudo.bash"
DESTINATION_PATH="$HOME/.local/bin/sudo"

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: 'curl' is not installed. Please install 'curl' and try again."
  exit 1
fi

if curl -s -o "$DESTINATION_PATH" "$SCRIPT_URL"; then
  chmod +x "$DESTINATION_PATH"
  echo "🎉 sudoas script installed in $DESTINATION_PATH"
else
  echo "Failed to download and install the sudoas script."
fi
