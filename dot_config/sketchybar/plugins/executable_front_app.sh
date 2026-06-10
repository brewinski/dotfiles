#!/bin/sh

set_app_icon() {
  local app_name="$1"
  local cache_dir="/tmp/sketchybar_icons"
  local cache_file="$cache_dir/$(echo "$app_name" | tr ' ' '_').png"

  mkdir -p "$cache_dir"

  if [ ! -f "$cache_file" ]; then
    local app_path
    app_path=$(osascript -e "POSIX path of (path to application \"$app_name\")" 2>/dev/null | tr -d '\n')
    [ -z "$app_path" ] && return 1

    local icon_name
    icon_name=$(defaults read "${app_path}Contents/Info" CFBundleIconFile 2>/dev/null | tr -d '\n')
    [[ "$icon_name" != *.icns ]] && icon_name="${icon_name}.icns"

    local icon_path="${app_path}Contents/Resources/${icon_name}"
    [ ! -f "$icon_path" ] && return 1

    sips -s format png "$icon_path" --out "$cache_file" --resampleHeightWidth 20 20 &>/dev/null
  fi

  [ -f "$cache_file" ] || return 1

  sketchybar --set "$NAME" \
    label.drawing=off \
    background.image="$cache_file" \
    background.image.drawing=on \
    background.drawing=on \
    background.height=20
}

if [ "$SENDER" = "front_app_switched" ] || [ "$SENDER" = "forced" ]; then
  APP="${INFO:-$1}"
  set_app_icon "$APP" || sketchybar --set "$NAME" label.drawing=on label="$APP" background.image.drawing=off background.drawing=off
fi
