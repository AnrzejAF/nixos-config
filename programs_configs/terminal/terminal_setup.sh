#!/usr/bin/env bash

set -euo pipefail

backup_stow_conflicts() {
  local stow_dir="${1:-$PWD/dotfiles}"
  local backup_dir="$HOME/dotfiles_backup"
  mkdir -p "$backup_dir"

  echo "Scanning $stow_dir for potential conflicts..."

  find "$stow_dir" -type f -o -type l | while read -r path; do
    local rel_path="${path#$stow_dir/}"
    local target="$HOME/$rel_path"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "Backing up: $target → $backup_dir/$rel_path"
      mkdir -p "$backup_dir/$(dirname "$rel_path")"
      mv "$target" "$backup_dir/$rel_path"
    else
      echo "No conflict: $target"
    fi
  done
}

backup_stow_conflicts

echo "Linking dotfiles using stow..."
stow -v -t "$HOME" dotfiles
