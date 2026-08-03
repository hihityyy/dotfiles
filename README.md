# dotfiles

My personal configuration files for Arch Linux with Niri Wayland compositor.

# Dependencies

## Arch
```bash
sudo pacman -S niri kitty fish yazi zoxide lsd  xdg-desktop-portal-gnome celluloid eog neovim nlohmann-json jq
paru -S noctalia obs-cmd
```

## Debian/Ubuntu
```bash
sudo apt install niri kitty fish yazi zoxide fonts-firacode xdg-desktop-portal qt6ct playerctl celluloid eog neovim nlohmann-json3-dev jq
cargo install lsd
```

## Fedora
```bash
sudo dnf install niri kitty fish zoxide fira-code-fonts xdg-desktop-portal qt6ct playerctl celluloid eog neovim nlohmann-json-devel jq
cargo install lsd yazi-fm
```

> The `noctalia` theme used by kitty/niri/yazi ships with `noctalia-shell` (see the `yay` line above) — nothing extra to install for it.

## Fish setup

Prompt theme is [tide](https://github.com/IlanCosman/tide), installed via [fisher](https://github.com/jorgebucaran/fisher).

```bash
# install fisher (plugin manager)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# install plugins from fish_plugins (this pulls in tide)
fisher update
```

If tide needs reconfiguring afterwards:
```bash
tide configure
```

## Wallpapers

My wallpapers are [here](https://golnk.ru/YGARz).

![preview](preview.png)
