# dotfiles-droy

Personal development environment configuration.

## Setup

```bash
git clone https://github.com/droyaner/dotfiles-droy.git ~/dotfiles-droy
cd ~/dotfiles-droy
sudo apt install xclip  # or wl-clipboard for Wayland
stow -v -t ~ .
nvim  # plugins auto-install
```

Inside Neovim: `:Copilot auth`

## Requirements

- Neovim 0.9+
- Node.js 22+
- Git
- GNU Stow
- xclip or wl-clipboard

## Included

Neovim: LSP (pyright, clangd), blink.cmp, Copilot, nvim-tree, fzf-lua, gitsigns, Tokyo Night
ZSH: zinit, Powerlevel10k, fzf

## Troubleshooting

Clipboard error: Install xclip (X11) or wl-clipboard (Wayland), then restart Neovim.

