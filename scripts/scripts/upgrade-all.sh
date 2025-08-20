#!/usr/bin/env bash

echo "System Packages"
sudo dnf upgrade \
    --refresh \
    --color=always

flatpak update

echo "nvim"
declare -a plugin_update_commands=(
    'Lazy! sync'
    'MasonUpdate'
    'TSUpdateSync'
)
# MasonUpdate doesn't pull in new LSPs, it just updates the registry
for command in "${plugin_update_commands[@]}"; do
    nvim --headless "+$command" "+qa"
    echo ""
done

echo "pipx"
pipx upgrade-all

echo "uv"
uv tool upgrade --all

echo "cargo"
# https://github.com/rust-lang/cargo/issues/2082#issuecomment-851346910
cargo install --list | grep -v '^ ' | cut -d' ' -f 1 | xargs cargo install

echo "tmux"
"${XDG_DATA_HOME}/tmux/plugins/tpm/bin/update_plugins" all

echo "ZSH Plugins"
antidote update
