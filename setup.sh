#!/bin/bash

# Healthcare Python Dev - AI Context Framework Setup Script
# This script downloads and installs this repository's framework files
# into your project's root directory (excluding README.md, LICENSE, setup.sh)
#
# Environment Variables:
#   FORCE_CONTINUE=yes    - Skip project root directory check in non-interactive mode
#   FORCE_OVERWRITE=yes   - Overwrite existing files/directories when collisions are detected (non-interactive)

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Globals
DRY_RUN="${DRY_RUN:-no}"
OVERWRITE_MODE="ask"  # ask|overwrite|skip

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

# Parse CLI arguments
parse_args() {
    for arg in "$@"; do
        case "$arg" in
            --dry-run)
                DRY_RUN="yes"
                ;;
        esac
    done
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

# Preflight check for existing files that would be overwritten
check_existing_installation() {
    local src_dir="$1"
    shift || true
    local -a excludes=("README.md" "LICENSE" "setup.sh")

    # Build list of items to copy
    local -a items=()
    while IFS= read -r item; do
        # Skip excluded names
        local base
        base="$(basename "$item")"
        local skip=false
        for ex in "${excludes[@]}"; do
            if [[ "$base" == "$ex" ]]; then
                skip=true
                break
            fi
        done
        $skip && continue
        items+=("$base")
    done < <(ls -1 "$src_dir")

    # Detect any collisions
    local collisions=()
    for name in "${items[@]}"; do
        if [[ -e "$name" ]]; then
            collisions+=("$name")
        fi
    done

    if [[ ${#collisions[@]} -gt 0 ]]; then
        if [[ -t 0 ]]; then
            print_warning "The following items already exist: ${collisions[*]}"
            read -p "Overwrite existing items? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                OVERWRITE_MODE="overwrite"
            else
                OVERWRITE_MODE="skip"
                print_warning "Existing items will be skipped"
            fi
        else
            if [[ "$FORCE_OVERWRITE" == "yes" ]]; then
                print_warning "Overwriting existing items due to FORCE_OVERWRITE=yes"
                OVERWRITE_MODE="overwrite"
            else
                print_warning "Non-interactive mode: existing items will be skipped: ${collisions[*]}"
                OVERWRITE_MODE="skip"
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

    # Extract repository
    print_status "Extracting framework files..."
    tar -xzf "$TEMP_DIR/healthcare-python-dev.tar.gz" -C "$TEMP_DIR"
    FRAMEWORK_DIR="$TEMP_DIR/healthcare-python-dev-main"
    
    # Build list of items to install (excluding certain files)
    mapfile -t ITEMS < <(ls -1 "$FRAMEWORK_DIR")
    EXCLUDES=("README.md" "LICENSE" "setup.sh")
    TO_COPY=()
    for name in "${ITEMS[@]}"; do
        skip=false
        for ex in "${EXCLUDES[@]}"; do
            if [[ "$name" == "$ex" ]]; then
                skip=true
                break
            fi
        done
        $skip && continue
        TO_COPY+=("$name")
    done

    # If dry-run, only print what would happen and exit
    if [[ "$DRY_RUN" == "yes" ]]; then
        print_status "Dry run enabled. No files will be copied."
        echo "Would install the following items to $(pwd):"
        for n in "${TO_COPY[@]}"; do
            echo "  - $n" 
        done

        # Show any overwrites
        OVERWRITES=()
        for n in "${TO_COPY[@]}"; do
            if [[ -e "$n" ]]; then
                OVERWRITES+=("$n")
            fi
        done
        if [[ ${#OVERWRITES[@]} -gt 0 ]]; then
            print_warning "The following items would be overwritten: ${OVERWRITES[*]}"
        else
            print_status "No existing files would be overwritten."
        fi

        # Cleanup and exit
        rm -rf "$TEMP_DIR"
        return 0
    fi

    # Preflight overwrite check (interactive/CI behavior)
    check_existing_installation "$FRAMEWORK_DIR"

    # Perform copy
    SKIPPED=()
    for item in "${TO_COPY[@]}"; do
        if [[ -e "$item" ]]; then
            if [[ "$OVERWRITE_MODE" == "overwrite" ]]; then
                : # fall through to copy
            else
                print_warning "Skipping existing $item"
                SKIPPED+=("$item")
                continue
            fi
        fi
        if [[ -d "$FRAMEWORK_DIR/$item" ]]; then
            cp -r "$FRAMEWORK_DIR/$item" .
        elif [[ -f "$FRAMEWORK_DIR/$item" ]]; then
            cp "$FRAMEWORK_DIR/$item" .
        fi
    done

    if [[ ${#SKIPPED[@]} -gt 0 ]]; then
        print_status "Skipped (already existed): ${SKIPPED[*]}"
    fi

    # Cleanup
    rm -rf "$TEMP_DIR"
}

## Removed redundant per-file download steps; all files are installed from the archive

# Create CLAUDE.md if it doesn't exist
create_claude_md() {
    if [[ ! -f "CLAUDE.md" ]]; then
        if [[ "$DRY_RUN" == "yes" ]]; then
            print_status "Dry run: would create CLAUDE.md"
            return 0
        fi
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
    print_status "Healthcare Python Dev - AI Context Framework Setup"
    echo "=================================================="
    echo
    parse_args "$@"
    check_project_root
    download_framework
    create_claude_md
    
    echo
    print_success "Healthcare Python Dev framework successfully installed!"
    echo
    print_status "Next steps:"
    echo "  1. Review prompt-engineering/AGENT-ONBOARDING.md"
    echo "  2. Customize the framework for your specific project needs"
    echo "  3. Start using the specialized agents and commands with your AI assistant"
    echo
    print_status "Available agents:"
    if [[ -d "prompt-engineering/agents" ]]; then
        shopt -s nullglob
        AGENTS=(prompt-engineering/agents/*.md)
        if [[ ${#AGENTS[@]} -eq 0 ]]; then
            echo "  (none)"
        else
            for agent in "${AGENTS[@]}"; do
                echo "  - $(basename "$agent")"
            done
        fi
        shopt -u nullglob
    else
        echo "  (none)"
    fi
    echo
    print_status "Available commands:"
    if [[ -d "prompt-engineering/commands" ]]; then
        shopt -s nullglob
        CMDS=(prompt-engineering/commands/*.md)
        if [[ ${#CMDS[@]} -eq 0 ]]; then
            echo "  (none)"
        else
            for command in "${CMDS[@]}"; do
                echo "  - $(basename "$command")"
            done
        fi
        shopt -u nullglob
    else
        echo "  (none)"
    fi
    echo
}

# Run the main function
main "$@"