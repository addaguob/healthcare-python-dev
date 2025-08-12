#!/bin/bash

# Healthcare Python Dev - AI Context Framework Setup Script
# This script downloads and installs the prompt-engineering framework
# into your project's root directory
#
# Environment Variables:
#   FORCE_CONTINUE=yes    - Skip project root directory check in non-interactive mode
#   FORCE_OVERWRITE=yes   - Overwrite existing prompt-engineering directory in non-interactive mode

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in a project root directory
check_project_root() {
    print_status "Checking if current directory is a project root..."
    
    if [[ ! -f "package.json" && ! -f "pyproject.toml" && ! -f "Cargo.toml" && ! -f "go.mod" && ! -f "pom.xml" && ! -d ".git" ]]; then
        print_warning "No common project files detected (package.json, pyproject.toml, etc.)"
        print_warning "This appears to be a clean/empty directory - proceeding with installation"
    else
        print_status "Project files detected - proceeding with installation"
    fi
}

# Check if prompt-engineering directory already exists
check_existing_installation() {
    if [[ -d "prompt-engineering" ]]; then
        print_warning "prompt-engineering directory already exists"
        
        # Check if running in interactive mode
        if [[ -t 0 ]]; then
            read -p "Do you want to overwrite it? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_status "Removing existing prompt-engineering directory..."
                rm -rf prompt-engineering
            else
                print_error "Setup cancelled"
                exit 1
            fi
        else
            # Non-interactive mode - check for environment variable override
            if [[ "$FORCE_OVERWRITE" != "yes" ]]; then
                print_error "Running in non-interactive mode and prompt-engineering directory exists."
                print_error "Set FORCE_OVERWRITE=yes environment variable to overwrite."
                exit 1
            else
                print_warning "Overwriting due to FORCE_OVERWRITE=yes"
                print_status "Removing existing prompt-engineering directory..."
                rm -rf prompt-engineering
            fi
        fi
    fi
}

# Download and extract the framework
download_framework() {
    print_status "Downloading Healthcare Python Dev framework..."
    
    TEMP_DIR=$(mktemp -d)
    
    # Download the repository
    curl -L "https://github.com/addaguob/healthcare-python-dev/archive/refs/heads/main.tar.gz" \
        -o "$TEMP_DIR/healthcare-python-dev.tar.gz" \
        --progress-bar
    
    if [[ $? -ne 0 ]]; then
        print_error "Failed to download framework"
        rm -rf "$TEMP_DIR"
        exit 1
    fi
    
    # Extract all files except LICENSE and README.md
    print_status "Extracting framework files (excluding LICENSE and README.md)..."
    tar -xzf "$TEMP_DIR/healthcare-python-dev.tar.gz" -C "$TEMP_DIR"
    FRAMEWORK_DIR="$TEMP_DIR/healthcare-python-dev-main"
    for item in $(ls "$FRAMEWORK_DIR"); do
        if [[ "$item" != "LICENSE" && "$item" != "README.md" ]]; then
            if [[ -d "$FRAMEWORK_DIR/$item" ]]; then
                cp -r "$FRAMEWORK_DIR/$item" .
            elif [[ -f "$FRAMEWORK_DIR/$item" ]]; then
                cp "$FRAMEWORK_DIR/$item" .
            fi
        fi
    done
    # Cleanup
    rm -rf "$TEMP_DIR"
}

# Download additional AI instruction files
download_ai_instructions() {
    print_status "Downloading AI instruction files..."
    
    # Create .github directory if it doesn't exist
    mkdir -p .github
    
    # Download GitHub Copilot instructions
    if [[ ! -f ".github/copilot-instructions.md" ]]; then
        print_status "Downloading GitHub Copilot instructions..."
        curl -L "https://raw.githubusercontent.com/addaguob/healthcare-python-dev/main/.github/copilot-instructions.md" \
            -o ".github/copilot-instructions.md" \
            --silent
        
        if [[ $? -eq 0 ]]; then
            print_success "Downloaded .github/copilot-instructions.md"
        else
            print_warning "Failed to download .github/copilot-instructions.md"
        fi
    else
        print_warning ".github/copilot-instructions.md already exists, skipping"
    fi
    
    # Download Gemini instructions
    if [[ ! -f "GEMINI.md" ]]; then
        print_status "Downloading Gemini instructions..."
        curl -L "https://raw.githubusercontent.com/addaguob/healthcare-python-dev/main/GEMINI.md" \
            -o "GEMINI.md" \
            --silent
        
        if [[ $? -eq 0 ]]; then
            print_success "Downloaded GEMINI.md"
        else
            print_warning "Failed to download GEMINI.md"
        fi
    else
        print_warning "GEMINI.md already exists, skipping"
    fi
}

# Create CLAUDE.md if it doesn't exist
create_claude_md() {
    if [[ ! -f "CLAUDE.md" ]]; then
        print_status "Creating CLAUDE.md file..."
        cat > CLAUDE.md << 'EOF'
# CLAUDE.md

## Project Instructions

This file contains instructions for AI assistants working on this project.

### Framework Integration

This project uses the Healthcare Engineering AI Context Framework. 
The prompt-engineering directory contains specialized agents and commands
that help AI assistants understand the project structure and conventions.

### Getting Started

See: prompt-engineering/AGENT-ONBOARDING.md for detailed onboarding instructions.

### Important Reminders

- Always follow the project's coding conventions
- Use the specialized agents in prompt-engineering/agents/ for domain-specific tasks
- Reference the commands in prompt-engineering/commands/ for common operations
- Ensure healthcare compliance when working with medical data

EOF
        print_success "Created CLAUDE.md"
    else
        print_warning "CLAUDE.md already exists, skipping creation"
    fi
}

# Main execution
main() {
    echo
    print_status "Healthcare Engineering - AI Context Framework Setup"
    echo "=================================================="
    echo
    
    check_project_root
    check_existing_installation
    download_framework
    download_ai_instructions
    create_claude_md
    
    echo
    print_success "Healthcare Engineering framework successfully installed!"
    echo
    print_status "Next steps:"
    echo "  1. Review prompt-engineering/AGENT-ONBOARDING.md"
    echo "  2. Customize the framework for your specific project needs"
    echo "  3. Start using the specialized agents and commands with your AI assistant"
    echo
    print_status "Available agents:"
    if [[ -d "prompt-engineering/agents" ]]; then
        for agent in prompt-engineering/agents/*.md; do
            agent_name=$(basename "$agent" .md)
            echo "  - $agent_name"
        done
    fi
    echo
    print_status "Available commands:"
    if [[ -d "prompt-engineering/commands" ]]; then
        for command in prompt-engineering/commands/*.md; do
            command_name=$(basename "$command" .md)
            echo "  - $command_name"
        done
    fi
    echo
}

# Run the main function
main "$@"