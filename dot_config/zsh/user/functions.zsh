upgrade-tooling (){
    printf "Brew\n"
    brew bundle install --quiet
    # brew bundle --cleanup --quiet

    printf "NVim\n"

    # MasonUpdate doesn't pull in new LSPs
    for plugin_update_command in 'Lazy! sync' 'MasonUpdate' 'TSUpdate'; do
        nvim --headless "+$plugin_update_command" "+qa"
    done

    # printf "Tmux"

    printf "ZSH Plugins\n"
    antigen update
}
