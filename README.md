# zsh-config

Powerful but tastefully minimal zsh configuration — no vim/neovim, no vi-mode.
Adapted from [radleylewis/zsh](https://github.com/radleylewis/zsh), with the
vi keybinding layer removed and a starship-based transient prompt added.

## Dependencies

### Ubuntu

```sh
sudo apt install zsh eza bat fd-find fzf ripgrep
# zoxide and starship don't have apt packages — install separately
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl -sS https://starship.rs/install.sh | sh
# Ubuntu ships bat and fd under different names — symlink them so everything works
mkdir -p ~/.local/bin
ln -s $(which batcat) ~/.local/bin/bat
ln -s $(which fdfind) ~/.local/bin/fd
```

### macOS

```sh
brew install zsh eza bat fd fzf zoxide starship ripgrep
```

## Setup

**1. Clone the repo**

```sh
git clone git@github.com:jiangqucheng/zsh-config.git ~/.config/zsh
```

**2. Point zsh at the config directory**

Add the following to `/etc/zsh/zshenv`:

```sh
if [[ -z "$XDG_CONFIG_HOME" ]]
then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

**3. Set zsh as your default shell**

```sh
chsh -s $(which zsh)
```

**4. Create required directories**

```sh
mkdir -p ~/.local/state/zsh   # history
mkdir -p ~/.cache/zsh         # completion cache
```

**5. Start a new shell**

Plugins are installed automatically on first launch via the built-in plugin manager.

## Plugins

Managed without a third-party plugin manager. Plugins are cloned into
`$ZDOTDIR/plugins/` on first launch.

| Plugin                                                                                    | Purpose                                                    |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)  | Syntax highlighting                                          |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)                    | Fish-style inline suggestions                                |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)  | Up/down arrow history filtering                              |
| [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)                      | Real-time completion/history menu as you type                |

No vi-mode plugin — this config doesn't touch `bindkey -v` and never installs
neovim/vim as a dependency.

To update all plugins:

```sh
zplugin-update
```

## Keybindings

| Key       | Action                                              |
| --------- | ---------------------------------------------------- |
| `Ctrl+R`  | Fuzzy history search (fzf, full-screen)               |
| `Ctrl+T`  | Fuzzy file search including hidden files (fzf + fd)   |
| `Ctrl+F`  | Fuzzy file search excluding hidden files (fzf + fd)   |
| `Ctrl+→`  | Move forward one word                                 |
| `Ctrl+←`  | Move backward one word                                |
| `↑` / `↓` | History search by substring                           |
| `Ctrl+\`  | Toggle autosuggestions                                |

## Starship Config

Included in the repo at [`starship.toml`](./starship.toml) and loaded
automatically via `STARSHIP_CONFIG` in `.zshenv`. Powerline-style bubble
segments: OS icon + directory on the left, exit status / command duration /
conda env / time on the right. Requires a [Nerd Font](https://www.nerdfonts.com)
in your terminal.

## Transient Prompt

[`transient-prompt.zsh`](./transient-prompt.zsh) collapses every prompt except
the one you're currently typing at into a single colored arrow (green on
success, red on failure) — similar to Powerlevel10k's transient prompt.

This isn't an official starship feature for zsh (starship's docs only cover
PowerShell/Fish/Bash-with-Ble.sh); it's implemented with a `zle-line-init`
widget that temporarily swaps `$PROMPT` for a one-liner right before a command
runs, then restores the full prompt for the next draw.

## Notes on deviations from upstream

This is adapted from [radleylewis/zsh](https://github.com/radleylewis/zsh),
with the following changes:

- Removed `zsh-vi-mode` and all vi-mode keybindings/hooks (`ZVM_*`, `zvm_after_init`) — not used
- Removed neovim from every dependency list and dropped `alias vim='nvim'`
- Dropped Arch Linux install instructions (Ubuntu + macOS only)
- Added `zsh-autocomplete` for an always-visible completion/history menu
- Added `transient-prompt.zsh` (see above) and a custom `starship.toml`
- Removed author-specific aliases unrelated to this setup (webcam/mpv `stream`, `lf`)
