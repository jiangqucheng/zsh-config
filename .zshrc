# Powerful but minimal zsh configuration
# Based on: https://github.com/radleylewis/zsh
# Customized: removed nvim/vi-mode, kept zsh-autosuggestions + fzf full-screen history
#
# Uses:
# Plugins: fast-syntax-highlighting, zsh-autosuggestions, zsh-history-substring-search
# Prompt: starship
# Navigation: zoxide, fzf, fd
# CLI tools: eza, bat, ripgrep
# =========================================================
# History
# =========================================================
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT # sort file10 after file9, not after file1

# =========================================================
# Completion
# =========================================================
# No compinit here: zsh-autocomplete (plugins.zsh) runs it at the first prompt.
# Calling it earlier builds a comp dump without autocomplete's own #autoload
# helpers ("command not found: _autocomplete__unambiguous" on Tab).
# Enable interactive completion menu selection
zstyle ':completion:*' menu select
# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # lowercase input matches upper and lower

# =========================================================
# Fuzzy finder
# =========================================================
# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Local Git-cloned fzf
if [[ -f "$HOME/.fzf/shell/key-bindings.zsh" ]]; then
  source "$HOME/.fzf/shell/key-bindings.zsh"
  source "$HOME/.fzf/shell/completion.zsh"
fi

# =========================================================
# Modular Config Files
# =========================================================
# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Transient prompt (collapses old prompts, p10k-style). Must register its
# zle-line-finish hook before plugins.zsh: once fast-syntax-highlighting has
# wrapped zle-line-finish, add-zle-hook-widget recurses until FUNCNEST.
source "$ZDOTDIR/transient-prompt.zsh"

# Plugins and plugin manager. Load before anything that calls compdef:
# zsh-autocomplete queues those calls and replays them after its compinit.
source "$ZDOTDIR/plugins.zsh"

# Smart directory navigation (zoxide registers its completion via compdef)
eval "$(zoxide init zsh)"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings (after plugins: zsh-autocomplete rebinds ^R/↑/↓ when sourced)
source "$ZDOTDIR/bindings.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

# =========================================================
# User Custom Configurations
# =========================================================
if [[ -f "$ZDOTDIR/local.zsh" ]]; then
  source "$ZDOTDIR/local.zsh"
fi


# =========================================================
# Change Window Title
# =========================================================
function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
    # echo -ne "\033]0; $(basename "$PWD") "$USER"@"$HOST" \007"
}
precmd_functions+=(set_win_title)


# =========================================================
# environment modules (if /usr/bin/modulecmd exists)
# =========================================================
if [ -x /usr/bin/modulecmd ]; then
  case "$0" in
          -sh|sh|*/sh)	modules_shell=sh ;;
       -ksh|ksh|*/ksh)	modules_shell=ksh ;;
       -zsh|zsh|*/zsh)	modules_shell=zsh ;;
    -bash|bash|*/bash)	modules_shell=bash ;;
  esac
  module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
fi
