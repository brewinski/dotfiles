#!/usr/bin/env zsh

export PATH="/opt/homebrew/bin:$PATH"

WORKSPACE="$1"
ICON_CACHE="/tmp/sketchybar_icons"
MAX_ICONS=5

# Update workspace highlight
if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi

# Get all unique app names in this workspace
ALL_APPS=("${(@f)$(aerospace list-windows --workspace "$WORKSPACE" --format "%{app-name}" 2>/dev/null | sort -u)}")
TOTAL=${#ALL_APPS[@]}
APPS=("${ALL_APPS[@]:0:$MAX_ICONS}")

mkdir -p "$ICON_CACHE"

for i in {1..${#APPS[@]}}; do
  app="${APPS[$i]}"
  [ -z "$app" ] && continue

  cache_file="$ICON_CACHE/$(echo "$app" | tr ' /' '__').png"

  if [ ! -f "$cache_file" ]; then
    app_path=$(osascript -e "POSIX path of (path to application \"$app\")" 2>/dev/null | tr -d '\n')
    if [ -n "$app_path" ]; then
      icon_name=$(defaults read "${app_path}Contents/Info" CFBundleIconFile 2>/dev/null | tr -d '\n')
      [[ "$icon_name" != *.icns ]] && icon_name="${icon_name}.icns"
      icon_path="${app_path}Contents/Resources/${icon_name}"
      [ -f "$icon_path" ] && sips -s format png "$icon_path" --out "$cache_file" --resampleHeightWidth 18 18 &>/dev/null
    fi
  fi

  if [ -f "$cache_file" ]; then
    sketchybar --set "ws_icon_${WORKSPACE}_${i}" \
      drawing=on \
      width=20 \
      background.image="$cache_file" \
      background.image.drawing=on \
      background.drawing=on \
      background.height=18
  else
    sketchybar --set "ws_icon_${WORKSPACE}_${i}" drawing=off
  fi
done

# Hide unused icon slots
local first_unused=$(( ${#APPS[@]} + 1 ))
if (( first_unused <= MAX_ICONS )); then
  for i in {$first_unused..$MAX_ICONS}; do
    sketchybar --set "ws_icon_${WORKSPACE}_${i}" drawing=off
  done
fi

# Show overflow indicator if there are more apps than MAX_ICONS
if (( TOTAL > MAX_ICONS )); then
  local overflow=$(( TOTAL - MAX_ICONS ))
  sketchybar --set "ws_more_${WORKSPACE}" drawing=on label="+${overflow}"
else
  sketchybar --set "ws_more_${WORKSPACE}" drawing=off
fi
