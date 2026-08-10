#!/usr/bin/env bash
set -euo pipefail

fzf_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/fzf"
sh_theme_file="$fzf_config_dir/noctalia.sh"
fish_theme_file="$fzf_config_dir/noctalia.fish"

mkdir -p "$fzf_config_dir"
touch "$sh_theme_file" "$fish_theme_file"

add_line_if_missing() {
  local rc_file="$1" line="$2"
  [ -f "$rc_file" ] || return 0
  grep -Fxq -- "$line" "$rc_file" 2>/dev/null && return 0
  printf '\n# Noctalia: fzf theme\n%s\n' "$line" >>"$rc_file"
}

add_line_if_missing "$HOME/.bashrc" "[ -f \"$sh_theme_file\" ] && source \"$sh_theme_file\""
add_line_if_missing "$HOME/.zshrc"  "[ -f \"$sh_theme_file\" ] && source \"$sh_theme_file\""

fish_conf="$HOME/.config/fish/config.fish"
if [ -f "$fish_conf" ]; then
  add_line_if_missing "$fish_conf" "test -f \"$fish_theme_file\"; and source \"$fish_theme_file\""
fi

if command -v fzf >/dev/null 2>&1; then
  echo "fzf theme written to $sh_theme_file and $fish_theme_file"
else
  echo "Warning: 'fzf' executable not found. The theme files were still generated."
fi
