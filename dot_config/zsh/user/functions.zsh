upgrade-tooling (){
    printf "Brew Update"
    brew bundle install --quiet
    # brew bundle --cleanup --quiet

    printf "NVIM Update\n"

    # MasonUpdate doesn't pull in new LSPs
    for command in 'PackerSync' 'MasonUpdate' 'TSUpdate'; do
        printf "%s %s \n" $command $(nvim --headless +$command +qa)
    done

    # printf "Tmux"

    printf "ZSH Plugins"
    antigen update
}
