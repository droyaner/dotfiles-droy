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

# 5) Oh-My-Zsh-style snippets (without fzf to avoid conflicts)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
# zinit snippet OMZP::fzf        # intentionally disabled (fzf-tab is used instead)
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZP::web-search
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::alias-finder

# Alias-finder configuration
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

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
bindkey '^[w' kill-region

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

alias ls='ls --color'
alias vim='nvim'
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

# =========================
#   Integrations
# =========================

# Do NOT call "eval \"$(fzf --zsh)\"" to avoid conflicts with fzf-tab
# eval "$(fzf --zsh)"

# zoxide: keep normal "cd" behavior, use `z` / completion instead
eval "$(zoxide init zsh)"

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
#       cd ../..<TAB>   -> cd ../../
#       cd ../../..<TAB> -> cd ../../../
# =========================

# Remember whatever widget TAB is currently bound to (fzf-tab or default)
if [[ -z $SMART_TAB_ORIG_WIDGET ]]; then
  SMART_TAB_ORIG_WIDGET=${${"$(bindkey '^I')"##* }:-expand-or-complete}
fi

smart_cd_slash() {
  emulate -L zsh
  setopt localoptions

  # If the line starts with "cd ", cursor is at end, and buffer ends with "..",
  # append a slash. This covers "cd ..", "cd ../..", "cd ../../..", etc.
  if [[ $BUFFER == cd\ * && $CURSOR -eq ${#BUFFER} && $BUFFER == *.. ]]; then
    BUFFER+="/"
    (( CURSOR++ ))
    return
  fi

  # Otherwise call the original TAB widget (fzf-tab or whatever was bound)
  zle "$SMART_TAB_ORIG_WIDGET"
}

zle -N smart_cd_slash
bindkey '^I' smart_cd_slash   # ^I = TAB

# =========================
#   Home Assistant helper
# =========================

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

# =========================
#   NVM (Node Version Manager)
# =========================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
