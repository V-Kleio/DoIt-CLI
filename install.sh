#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Configuration variables
REPO_URL="https://github.com/V-Kleio/DoIt-CLI"
DEFAULT_INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/doit"
TEMPLATES_DIR="$CONFIG_DIR/templates"
BOILERPLATES_DIR="$CONFIG_DIR/boilerplates"
TEMP_DIR=$(mktemp -d)

cleanup() {
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

print_header() {
  echo -e "${BLUE}
╭───────────────────────────────────────╮
│                                       │
│     DoIt CLI Installer ✨             │
│                                       │
╰───────────────────────────────────────╯${NC}"
  echo
}

# Display help
show_help() {
    cat << EOF
Usage: ./install.sh [options]

Options:
  --help              Show this help message
  --prefix=DIR        Set installation directory (default: ~/.local/bin)
  --global            Install for all users (requires sudo, installs to /usr/local/bin)

Example:
  ./install.sh --prefix=~/bin
  ./install.sh --global
EOF
}

# Process arguments
GLOBAL_INSTALL=false
INSTALL_DIR="$DEFAULT_INSTALL_DIR"

for arg in "$@"; do
    case $arg in
        --help)
            show_help
            exit 0
            ;;
        --prefix=*)
            INSTALL_DIR="${arg#*=}"
            ;;
        --global)
            GLOBAL_INSTALL=true
            INSTALL_DIR="/usr/local/bin"
            ;;
        *)
            echo -e "${RED}Unknown option: $arg${NC}"
            show_help
            exit 1
            ;;
    esac
done

detect_installation_mode() {
    if [[ -f "./bin/doit" && -d "./templates" ]]; then
        echo "local"
    else
        echo "remote"
    fi
}

download_project() {
    echo -e "${BLUE}Downloading tmux-doit...${NC}"
    
    if command -v git >/dev/null 2>&1; then
        git clone --depth 1 "$REPO_URL" "$TEMP_DIR/tmux-doit" || {
            echo -e "${RED}Failed to clone repository using git. Trying with curl...${NC}"
            download_with_curl
        }
    else
        download_with_curl
    fi
}

download_with_curl() {
    if command -v curl >/dev/null 2>&1; then
        curl -L "$REPO_URL/archive/main.tar.gz" | tar -xz -C "$TEMP_DIR" || {
            echo -e "${RED}Failed to download and extract repository.${NC}"
            exit 1
        }
        mv "$TEMP_DIR"/tmux-doit-* "$TEMP_DIR/tmux-doit"
    else
        echo -e "${RED}Neither git nor curl is installed. Cannot download project.${NC}"
        exit 1
    fi
}

detect_shell() {
    if [[ -n "$SHELL" ]]; then
        echo "$SHELL"
    elif [[ -f "$HOME/.bashrc" ]]; then
        echo "bash"
    elif [[ -f "$HOME/.zshrc" ]]; then
        echo "zsh"
    else
        echo "unknown"
    fi
}

main() {
    print_header

    INSTALL_MODE=$(detect_installation_mode)

    if [[ "$INSTALL_MODE" == "remote" ]]; then
        echo -e "${BLUE}Installing from remote repository...${NC}"
        download_project
        SCRIPT_DIR="$TEMP_DIR/tmux-doit"
        sleep 2
    else
        echo -e "${BLUE}Installing from local directory...${NC}"
        SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
        sleep 2
    fi

    echo -e "${BLUE}Checking requirements...${NC}"

    if ! command -v tmux >/dev/null 2>&1; then
        echo -e "${RED}❌ tmux is not installed. Please install it first.${NC}"
        exit 1
    fi

    if ! command -v jq >/dev/null 2>&1; then
        echo -e "${RED}❌ jq is not installed. Please install it first.${NC}"
        exit 1
    fi

    sleep 2
    echo -e "${GREEN}✅ All requirements satisfied${NC}"
    echo

    echo -e "${BLUE}Creating directories...${NC}"

    if [ "$GLOBAL_INSTALL" = true ]; then
        sudo mkdir -p "$INSTALL_DIR" || { echo -e "${RED}❌ Failed to create $INSTALL_DIR${NC}"; exit 1; }
    else
        mkdir -p "$INSTALL_DIR" || { echo -e "${RED}❌ Failed to create $INSTALL_DIR${NC}"; exit 1; }
    fi

    mkdir -p "$TEMPLATES_DIR" || { echo -e "${RED}❌ Failed to create $TEMPLATES_DIR${NC}"; exit 1; }
    mkdir -p "$BOILERPLATES_DIR" || { echo -e "${RED}❌ Failed to create $BOILERPLATES_DIR${NC}"; exit 1; }

    sleep 2
    echo -e "${GREEN}✅ Directories created${NC}"
    echo

    echo -e "${BLUE}Installing doit CLI...${NC}"

    if [ "$GLOBAL_INSTALL" = true ]; then
        sudo cp "$SCRIPT_DIR/bin/doit" "$INSTALL_DIR/" || { echo -e "${RED}❌ Failed to copy doit script${NC}"; exit 1; }
        sudo chmod +x "$INSTALL_DIR/doit" || { echo -e "${RED}❌ Failed to make doit script executable${NC}"; exit 1; }
    else
        cp "$SCRIPT_DIR/bin/doit" "$INSTALL_DIR/" || { echo -e "${RED}❌ Failed to copy doit script${NC}"; exit 1; }
        chmod +x "$INSTALL_DIR/doit" || { echo -e "${RED}❌ Failed to make doit script executable${NC}"; exit 1; }
    fi

    sleep 2
    echo -e "${GREEN}✅ doit CLI installed${NC}"
    echo

    echo -e "${BLUE}Installing default templates...${NC}"

    cp -n "$SCRIPT_DIR/templates/"*.json "$TEMPLATES_DIR/" 2>/dev/null || true

    if [ ! -f "$TEMPLATES_DIR/default.json" ]; then
        cp "$SCRIPT_DIR/templates/default.json" "$TEMPLATES_DIR/" || {
            echo -e "${YELLOW}⚠️  Could not find default template, creating minimal one${NC}"
            cat > "$TEMPLATES_DIR/default.json" << EOF
{
  "name": "Default Template",
  "description": "A default template with single window",
  "layout": {
    "windows": [
      {
        "name": "main",
        "panes": [
          { 
            "cmd": "echo '✨ Welcome to DoIt CLI!'"
          }
        ]
      }
    ]
  }
}
EOF
        }
    fi

    sleep 2
    echo -e "${GREEN}✅ Templates installed${NC}"
    echo

    sleep 1
    echo -e "${GREEN}🎉 Installation complete!${NC}"
    echo
    
    # Check if install dir is in PATH
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo -e "${YELLOW}⚠️  Note: $INSTALL_DIR is not in your PATH${NC}"
        read -p "Would you like to add it to your PATH automatically? (y/N) " add_to_path

        if [[ "$add_to_path" =~ ^[Yy]$ ]]; then
            shell_path=$(detect_shell)

            if [[ "$shell_path" == *"bash"* ]]; then
                config_file="$HOME/.bashrc"
            elif [[ "$shell_path" == *"zsh"* ]]; then
                config_file="$HOME/.zshrc"
            else
                config_file="$HOME/.profile"
            fi

            if [[ -f "$config_file" ]]; then
                echo -e "\n# Added by DoIt CLI installer" >> "$config_file"
                echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$config_file"
                echo -e "${GREEN}✅ Added to PATH in $config_file${NC}"
                echo -e "   To use doit right away, run: ${BLUE}source $config_file${NC}"
            else
                echo -e "${YELLOW}⚠️  Could not detect shell configuration file.${NC}"
                echo -e "   Please add this line to your shell profile manually:"
                echo -e "   ${BLUE}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
            fi
        else
            echo -e "   Add this line to your shell profile (e.g. ~/.bashrc):"
            echo -e "   ${BLUE}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
        fi
    fi
    echo -e "To get started, run: ${GREEN}doit help${NC}"
    echo -e "Enjoy using DoIt CLI! ✨"
}

main "$@"