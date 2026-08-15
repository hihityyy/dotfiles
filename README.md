# dotfiles

My personal configuration files for Arch Linux with the [Niri](https://github.com/YaLTeR/niri) Wayland compositor.

## Dependencies

```sh
sudo pacman -S niri kitty fish yazi zoxide lsd bat cava lazygit xdg-desktop-portal-gnome celluloid eog evince lollypop nautilus xdg-utils neovim nlohmann-json jq noctalia
```

## Fish setup

Prompt theme is [tide](https://github.com/IlanCosman/tide), installed via [fisher](https://github.com/jorgebucaran/fisher).

```sh
# install fisher (plugin manager)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# install plugins from fish_plugins (this pulls in tide)
fisher update
```

If tide needs reconfiguring afterwards:

```sh
tide configure
```

