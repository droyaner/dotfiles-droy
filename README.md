# Dotfiles-Droy

Personal dotfiles configuration for portable development environment.

## 📦 Installation

### Prerequisites

- **Neovim** >= 0.9.0
- **Node.js** (for GitHub Copilot)
- **Git**
- **GNU Stow** (for symlinking)

### Quick Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/droyaner/dotfiles-droy.git ~/dotfiles-droy
   cd ~/dotfiles-droy
   ```

2. **Stow the dotfiles:**
   ```bash
   stow -v -t ~ .
   ```

3. **Install Node.js** (for Copilot):
   ```bash
   # Using NVM (recommended)
   nvm install --lts
   
   # Or via package manager
   # Ubuntu/Debian: sudo apt install nodejs npm
   # macOS: brew install node
   ```

4. **Open Neovim and install plugins:**
   ```bash
   nvim
   ```
   Plugins will auto-install via lazy.nvim on first launch.

5. **Authenticate GitHub Copilot:**
   ```vim
   :Copilot auth
   ```
   
   **Troubleshooting:** If the browser doesn't open automatically:
   1. Copy the code shown in Neovim
   2. Manually open: https://github.com/login/device
   3. Paste the code and authorize
   
   Alternative method:
   ```vim
   :Copilot setup
   ```

## 🛠️ Configuration

### Neovim Features

- **LSP Support:** Python (pyright), C/C++ (clangd), GDScript (Godot)
- **Autocompletion:** blink.cmp with LSP integration
- **GitHub Copilot:** AI-powered code completion + chat
- **File Explorer:** nvim-tree
- **Fuzzy Finder:** fzf-lua
- **Theme:** Tokyo Night (moon variant)

### ZSH Features

- **Plugin Manager:** zinit
- **Theme:** Powerlevel10k
- **FZF Integration:** Ctrl+R for history search
- **SSH Completion:** Auto-complete from ~/.ssh/config
- **Conditional Loading:** Plugins load only when dependencies exist

## 📁 Structure

```
.config/
├── nvim/
│   ├── init.lua
│   └── lua/
│       ├── config/
│       │   ├── lazy.lua
│       │   ├── keymaps.lua
│       │   └── options.lua
│       └── plugins/
│           ├── ui.lua
│           ├── lsp.lua
│           ├── completion.lua
│           └── copilot.lua
└── wezterm/
    └── wezterm.lua
.zshrc
```

## ⚙️ Portability

This configuration is designed for maximum portability:
- ✅ Auto-installs missing dependencies (lazy.nvim, zinit, Mason)
- ✅ Conditional plugin loading (only loads if tools exist)
- ✅ Version pinning for stable, reproducible setups
- ✅ Works on Linux and macOS
- ✅ No hardcoded paths

## 📝 Notes

The README file is ignored by stow.
