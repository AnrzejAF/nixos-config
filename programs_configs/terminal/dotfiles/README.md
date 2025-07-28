
# Terminal Dotfiles Setup

This repository contains a structured setup for managing personal terminal configuration files using GNU Stow. It ensures clean, conflict-free symlinking of dotfiles such as `.zshrc`, `.p10k.zsh`, `.tmux.conf`, and custom Zsh functions.

## Features

- Modular structure with all config files grouped under `terminal/`
- Conflict-safe setup script that automatically backs up conflicting files to `~/dotfiles_backup/`
- Custom Zsh functions sourced from `~/.zsh/functions.zsh`
- Powerlevel10k (`.p10k.zsh`) and Tmux (`.tmux.conf`) configurations included
- Idempotent installation via `terminal_setup.sh`

## Structure

```bash
.
├── README.md
├── terminal_setup.sh
└── terminal
    ├── .p10k.zsh
    ├── .tmux.conf
    ├── .zshrc
    ├── .zshenv
        └── functions.zsh
        └── functions.zsh 
```

## Requirements

- `bash`
- `stow` (auto-installed by `setup.sh` if missing)
- `zsh` shell (recommended)
- Fonts supporting Powerline for `.p10k.zsh` (e.g., MesloLGS NF)

## Usage

Clone the repository and run the setup script:

```bash
git clone https://github.com/AnrzejAF/configs.git
cd configs
./terminal_setup.sh
```

This will:

1. Install `stow` if it's not already available.
2. Scan the `$HOME` directory for conflicting files and back them up to `~/dotfiles_backup/`.
3. Symlink files from the `terminal/` directory into `$HOME`.

## Custom Zsh Functions

You can define reusable shell functions inside:

```bash
~/.zsh/functions.zsh
```

This file is sourced automatically from `.zshrc` if included. Example usage:

```zsh
my_alias() {
  echo "This is a custom shell function"
}
```

## Notes

- The repo is designed to be safe to run multiple times.
- Only non-symlink conflicts are backed up; existing symlinks will be overwritten by Stow.
- You can extend the setup by adding more folders like `nvim/`, `git/`, etc., and referencing them in the `setup.sh` if needed.

## License

MIT License
```
# This project is licensed under the MIT License.