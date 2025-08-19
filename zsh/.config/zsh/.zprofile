if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export XDG_CURRENT_DESKTOP=sway
  exec sway
fi

command -v brew && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:$HOME/.local/bin"
