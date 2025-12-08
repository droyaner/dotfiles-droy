# Dotfiles-Droy

Personal dotfiles configuration for portable development environment.

## Installation

### Prerequisites

- Neovim >= 0.9.0
- Node.js >= 22 (for GitHub Copilot)
- Git
- GNU Stow (for symlinking)

### Quick Setup

1. Clone repository:
   ```bash
   git clone https://github.com/droyaner/dotfiles-droy.git ~/dotfiles-droy
   cd ~/dotfiles-droy
   ```

2. Stow dotfiles:
   ```bash
   stow -v -t ~ .
   ```

3. Install Node.js:
   ```bash
   nvm install 22
   nvm alias default 22
   ```

4. Open Neovim (plugins auto-install):
   ```bash
   nvim
   ```

5. Authenticate Copilot:
   ```vim
   :Copilot auth
   ```

## Configuration

### Neovim

- LSP: Python (pyright), C/C++ (clangd), GDScript (Godot)
- Completion: blink.cmp
- AI: GitHub Copilot + Chat
- File Explorer: nvim-tree
- Fuzzy Finder: fzf-lua
- Git: gitsigns
- Theme: Tokyo Night

### ZSH

- Plugin Manager: zinit
- Theme: Powerlevel10k
- FZF: Ctrl+R for history search
- SSH: Auto-completion from ~/.ssh/config
- Conditional loading for optional tools

## Structure

```
.config/nvim/
├── init.lua
└── lua/
    ├── config/
    │   ├── lazy.lua
    │   ├── keymaps.lua
    │   └── options.lua
    └── plugins/
        ├── ui.lua
        ├── lsp.lua
        ├── completion.lua
        ├── copilot.lua
        ├── git.lua
        └── which-key.lua
.zshrc
```

## Portability

- Auto-installs missing dependencies
- Conditional plugin loading
- Version pinning for stability
- Works on Linux and macOS
- No hardcoded paths

