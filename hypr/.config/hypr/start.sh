#!/usr/bin/env bash
swww-daemon &
swww img ~/Pictures/Wallpapers/hollow-knight.png
~/.config/waybar/waybar-autohide.sh &
foot --server &

nm-applet --indicator &
pypr --debug /tmp/pypr.log &
xrdb -load ~/.Xdefaults &

copyq &
gnome-keyring-daemon &
pkill dunst &
dunst &

#!/usr/bin/env bash
set -e

[[ -n $HYPRLAND_DEBUG_CONF ]] && exit 0
USAGE="\
Import environment variables 

Usgae: $0 <command>

Commands:
   tmux         import to tmux server
   system       import to systemd and dbus user session
   help         print this help
"

_envs=(
  # display
  WAYLAND_DISPLAY
  DISPLAY
  # xdg
  USERNAME
  XDG_BACKEND
  XDG_CURRENT_DESKTOP
  XDG_SESSION_TYPE
  XDG_SESSION_ID
  XDG_SESSION_CLASS
  XDG_SESSION_DESKTOP
  XDG_SEAT
  XDG_VTNR
  # hyprland
  HYPRLAND_CMD
  HYPRLAND_INSTANCE_SIGNATURE
  # sway
  SWAYSOCK
  # misc
  XCURSOR_SIZE
  # toolkit
  _JAVA_AWT_WM_NONREPARENTING
  QT_QPA_PLATFORM
  QT_WAYLAND_DISABLE_WINDOWDECORATION
  GRIM_DEFAULT_DIR
  # ssh
  SSH_AUTH_SOCK
)

case "$1" in
system)
  dbus-update-activation-environment --systemd "${_envs[@]}"
  ;;
tmux)
  for v in "${_envs[@]}"; do
    if [[ -n ${!v} ]]; then
      tmux setenv -g "$v" "${!v}"
    fi
  done
  ;;
help)
  echo -n "$USAGE"
  exit 0
  ;;
*)
  echo "operation reuqired"
  echo "use \"$0 help\" to see usage help"
  exit 1
  ;;
esac
