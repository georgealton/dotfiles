alias cat='bat'
alias ls='eza --icons'
alias tree='ls --tree'
alias vim='nvim'
alias vi='vim'


if command -v gmake > /dev/null; then
    alias make='gmake'
fi

alias cd='z'

IFS='' read -d '' -r profile_config <<"EOM"
import sys
import botocore.session as s

profile = sys.argv[1]

session = s.Session(profile=profile)
config = session.get_scoped_config()

account_id = config.get("sso_account_id", "")
account_name = config.get("sso_account_name", "")
role_name = config.get("sso_role_name", "")

print(f"Account Name: {account_name}")
print(f"Account Id  : {account_id}")
print(f"Role Name   : {role_name}")
EOM

_profile () {
    export AWS_PROFILE=$(aws configure list-profiles | \
    fzf \
    --tmux \
    --ignore-case \
    --height "30%" \
    --ghost "Profile Name..." \
    --no-multi \
    --preview "python -c '$profile_config' {}" \
    --preview-label "Profile Info" \
    --preview-window "right" \
    )
}

alias aws-profile=_profile
