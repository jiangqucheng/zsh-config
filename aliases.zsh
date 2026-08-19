# =========================================================
# Better ls / cat
# =========================================================
alias ls='eza --icons'
alias l='eza -lh --icons --git'       # Detailed listing
alias ll='eza -lagh --icons --git'     # Detailed listing including hidden files
alias la='ll'                         # Detailed listing including hidden files
alias tree='eza --tree --icons'       # Tree view
compdef eza=ls                        # Reuse ls completions for eza

alias cat='bat'

# =========================================================
# Core utilities
# =========================================================
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================
alias -- -='cd -' # -- prevents - being parsed as a flag; cd - jumps to previous directory

# =========================================================
# Git
# =========================================================
alias glog='PAGER="less -F -X" git log' # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 原配置里的 `alias vim='nvim'` 和 `lf`/`stream`（webcam/mpv 专用）已移除，
# 跟不用 vim 的场景无关。如果你自己有类似需求可以在这里加回来。
