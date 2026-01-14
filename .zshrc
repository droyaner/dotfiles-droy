# =========================
#   Powerlevel10k instant prompt
#   (must stay near the top)
# =========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================
#   Zinit setup
# =========================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# =========================
#   Powerlevel10k theme
# =========================
zinit ice depth=1
zinit light romkatv/powerlevel10k

# =========================
#   Completion stack
# =========================

# 1) Extra completion definitions
zinit light zsh-users/zsh-completions

# 2) Initialize zsh completion system
autoload -Uz compinit
compinit

# 3) fzf-tab (must be after compinit, before autosuggestions)
zinit light Aloxaf/fzf-tab

# 4) Plugins that hook into widgets / hints
zinit light zsh-users/zsh-autosuggestions

# 5) fzf binary and shell integration
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# 6) Oh-My-Zsh-style snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZP::web-search
zinit snippet OMZP::sudo

# Kubernetes plugins (only if kubectl is installed)
if command -v kubectl &> /dev/null; then
  zinit snippet OMZP::kubectl
  zinit snippet OMZP::kubectx
fi

zinit snippet OMZP::command-not-found

# Alias-finder (requires Python)
if command -v python3 &> /dev/null || command -v python &> /dev/null; then
  zinit snippet OMZP::alias-finder
  zstyle ':omz:plugins:alias-finder' autoload yes
  zstyle ':omz:plugins:alias-finder' longer yes
  zstyle ':omz:plugins:alias-finder' exact yes
  zstyle ':omz:plugins:alias-finder' cheaper yes
fi

# 6) zsh-syntax-highlighting MUST be last among plugins/snippets
zinit light zsh-users/zsh-syntax-highlighting

# Replay PATH and other environment changes recorded by zinit
zinit cdreplay -q

# =========================
#   Powerlevel10k user config
# =========================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =========================
#   Keybindings
# =========================

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Word operations
bindkey '^[[1;5C' forward-word         # Ctrl+Right: Word forward
bindkey '^[[1;5D' backward-word        # Ctrl+Left: Word backward


# =========================
#   History configuration
# =========================

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt HIST_VERIFY          # verify history-expanded commands before running
setopt HIST_BEEP            # beep on history-related errors

# =========================
#   Shell options
# =========================

setopt INTERACTIVE_COMMENTS # allow comments in interactive commands
setopt GLOBDOTS             # include dotfiles in globbing
setopt PIPE_FAIL            # pipelines fail if any element fails

# Options that affect completion behavior
setopt AUTO_LIST            # automatically list matches
setopt AUTO_MENU            # menu completion on repeated TAB
setopt AUTO_PARAM_SLASH     # append '/' to completed directories
setopt COMPLETE_IN_WORD     # allow completion in the middle of a word

# =========================
#   Completion styling
# =========================

# Ensure LS_COLORS is set (fallback if it isn't)
if [[ -z "$LS_COLORS" ]]; then
  eval "$(dircolors -b 2>/dev/null || true)"
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Use LS_COLORS for completion colorization
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Use a selection menu for completion (works nicely with fzf-tab)
zstyle ':completion:*' menu select

# Completion cache for speed
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zcompcache

# fzf-tab: previews and navigation
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:corrections' format '(%d)'
zstyle ':fzf-tab:*' switch-group ',' '.'   # switch groups in fzf with , and .

# =========================
#   Aliases
# =========================

# ls with colors (GNU ls uses --color, BSD ls uses -G)
if ls --color &> /dev/null; then
  alias ls='ls --color'
else
  alias ls='ls -G'
fi

alias vim='nvim'
alias n='nvim'
alias c='clear'
alias g='google'
alias py='python'

# Safer core utilities (interactive prompts)
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# zmv for bulk renaming using zsh patterns
autoload -Uz zmv
alias zmv='noglob zmv -W'

alias lg='lazygit'

# =========================
#   Integrations
# =========================

# SSH host completion from ~/.ssh/config
if [[ -r ~/.ssh/config ]]; then
  h=(${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
  if [[ ${#h[@]} -gt 0 ]]; then
    # Disable all default host sources
    zstyle ':completion:*:(ssh|scp|sftp):*' tag-order hosts
    zstyle ':completion:*:(ssh|scp|sftp):*' group-name ''
    # Only use our config hosts
    zstyle ':completion:*:ssh:*' hosts $h
    zstyle ':completion:*:scp:*' hosts $h
    zstyle ':completion:*:sftp:*' hosts $h
  fi
  unset h
fi

# zoxide: keep normal "cd" behavior, use `z` / completion instead
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# =========================
#   FZF power functions
# =========================

# Kill process with fzf
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --preview 'echo {}' --preview-window down:3:wrap | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -${1:-9}
  fi
}

# Git checkout branch with fzf
fgb() {
  local branch
  branch=$(git branch -a | grep -v HEAD | sed 's/^[* ]*//' | sed 's#remotes/origin/##' | sort -u | fzf --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {}')
  if [ -n "$branch" ]; then
    git checkout "$branch"
  fi
}

# Extra aliases and secrets (optional)
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

if [ -f ~/.secrets ]; then
  source ~/.secrets
fi

# =========================
#   Smart TAB wrapper
#   - Keep fzf-tab behavior
#   - Add:
#       cd ..<TAB>      -> cd ../
#       cp file ..<TAB> -> cp file ../
#       mv src ..<TAB>  -> mv src ../
#       rm ..<TAB>      -> rm ../
#       Works for any command that accepts paths
# =========================

# Remember whatever widget TAB is currently bound to (fzf-tab or default)
if [[ -z $SMART_TAB_ORIG_WIDGET ]]; then
  SMART_TAB_ORIG_WIDGET=${${"$(bindkey '^I')"##* }:-expand-or-complete}
fi

smart_path_slash() {
  emulate -L zsh
  setopt localoptions

  # Get the word under/before the cursor
  local word="${LBUFFER##* }"

  # If cursor is at end of line and the last word ends with "..",
  # append a slash. Works for: cd .., cp file .., mv src .., etc.
  if [[ $CURSOR -eq ${#BUFFER} && $word == *.. ]]; then
    BUFFER+="/"
    (( CURSOR++ ))
    return
  fi

  # Otherwise call the original TAB widget (fzf-tab or whatever was bound)
  zle "$SMART_TAB_ORIG_WIDGET"
}

zle -N smart_path_slash
bindkey '^I' smart_path_slash   # ^I = TAB

# =========================
#   Home Assistant helper
# =========================

if command -v curl &> /dev/null; then
ha_trigger() {
  : "${HA_HOST:="http://homeassistant:8123"}"

  if [[ -z "$HA_TOKEN" ]]; then
    echo "ERROR: HA_TOKEN is not set. Please check ~/.ha_secrets." >&2
    return 1
  fi

  if ! curl -s -f -X POST \
    -H "Authorization: Bearer $HA_TOKEN" \
    "$HA_HOST/api/services/automation/trigger" \
    -H "Authorization: Bearer $HA_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{\"entity_id\":\"automation.$1\",\"skip_condition\":true}" \
    > /dev/null; then
      echo "ERROR: unable to trigger '$1'." >&2
      return 1
  fi
}
fi

# =========================
#   NVM (Node Version Manager)
# =========================

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Unset any existing nvm aliases before loading
  unalias nvm 2>/dev/null
  unalias node 2>/dev/null
  unalias npm 2>/dev/null

  # Load NVM normally (needed for Neovim Copilot)
  . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# =========================
#   NixOS-specific config
# =========================

# Source NixOS-specific configuration (managed by Home Manager)
if [[ -f ~/.zshrc-nix ]]; then
  source ~/.zshrc-nix
fi
