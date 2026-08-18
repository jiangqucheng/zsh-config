# =========================================================
# Keybindings
# =========================================================
# 原配置里这些绑定是通过 zvm_after_init 钩子注册的，
# 因为 zsh-vi-mode 会在初始化时重置所有按键绑定。
# 现在没有 zsh-vi-mode 了，直接 bindkey 即可，不需要包一层钩子。

# Ctrl+Right -> move forward one word (^[[1;5C is the terminal escape code)
bindkey '^[[1;5C' forward-word
# Ctrl+Left -> move backward one word (^[[1;5D is the terminal escape code)
bindkey '^[[1;5D' backward-word

# Ctrl+F -> fzf file picker (no hidden files)
bindkey '^F' _fzf_file_no_hidden

# Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
bindkey '^\' autosuggest-toggle

# Up/Down -> history search by substring (^[[A/^[[B are up/down arrow escape codes)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
