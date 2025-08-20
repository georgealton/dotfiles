upgrade-tooling () {
    echo "System Packages"
    sudo dnf upgrade --refresh --color=always
    flatpak update 

    echo "nvim"
    # MasonUpdate doesn't pull in new LSPs
    for plugin_update_command in 'Lazy! sync' 'MasonUpdate' 'TSUpdateSync'; do
        nvim --headless "+$plugin_update_command" "+qa"
        echo ""
    done

    echo pipx
    pipx upgrade-all

    echo uv
    uv tool upgrade --all

    echo "tmux"
    ${XDG_DATA_HOME}/tmux/plugins/tpm/bin/update_plugins all


    echo "ZSH Plugins"
    if command -v antidote >/dev/null 2>&1; then
        antidote update
    fi
}
