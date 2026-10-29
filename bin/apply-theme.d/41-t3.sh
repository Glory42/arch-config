# T3 Code's Apollo theme
if [ -d ~/.t3/userdata ]; then
    mkdir -p ~/.t3/userdata/themes
    t3_colors=$(cat <<EOT
{
  "canvas": "#$bg",
  "chrome": "#$bg",
  "toolbar": "#$bg",
  "toolbarForeground": "#$fg",
  "toolbarBorder": "#$edge",
  "toolbarControl": "#$(mix "$bg" "$fg" 8)",
  "toolbarControlForeground": "#$fg",
  "toolbarControlHover": "#$(mix "$bg" "$fg" 14)",

  "surface": "#$(mix "$bg" "$fg" 4)",
  "surfaceRaised": "#$(mix "$bg" "$fg" 8)",
  "surfaceOverlay": "#$(mix "$bg" "$fg" 11)",

  "text": "#$fg",
  "textMuted": "#$dim",
  "border": "#$edge",
  "input": "#$(mix "$bg" "$fg" 22)",
  "focus": "#$accent",
  "accent": "#$accent",
  "accentForeground": "#$bg",

  "secondary": "#$(mix "$bg" "$fg" 10)",
  "secondaryForeground": "#$fg",
  "muted": "#$(mix "$bg" "$fg" 6)",
  "mutedForeground": "#$dim",
  "placeholder": "#$dimmer",
  "secondaryLabel": "#$dim",
  "iconMuted": "#$dim",

  "error": "#$(mix "$red" "$fg" 35)",
  "errorForeground": "#$(mix "$red" "$fg" 35)",
  "errorSurface": "#$(mix "$bg" "$red" 18)",
  "warning": "#$(mix "$yellow" "$fg" 35)",
  "warningForeground": "#$(mix "$yellow" "$fg" 35)",
  "warningSurface": "#$(mix "$bg" "$yellow" 18)",

  "update": "#$accent",
  "updateForeground": "#$fg",
  "updateSurface": "#$(mix "$bg" "$accent" 18)",
  "accentSurface": "#$(mix "$bg" "$accent" 16)",
  "accentSurfaceForeground": "#$fg",

  "messageSurface": "#$(mix "$bg" "$accent" 20)",
  "messageForeground": "#$fg",
  "messageAction": "#$accent",
  "messageActionForeground": "#$bg",
  "messageActionHover": "#$(mix "$accent" "$fg" 20)",

  "codeBackground": "#$dark_bg",
  "codeForeground": "#$fg",

  "sidebar": "#$dark_bg",
  "sidebarForeground": "#$fg",
  "sidebarMutedForeground": "#$dim",
  "sidebarControlSurface": "#$(mix "$dark_bg" "$fg" 10)",
  "sidebarRowHover": "#$(mix "$dark_bg" "$fg" 6)",
  "sidebarRowActive": "#$(mix "$dark_bg" "$accent" 18)",
  "sidebarRowSelected": "#$selection",
  "sidebarBorder": "#$edge",

  "terminalBackground": "#$bg",
  "terminalForeground": "#$fg",
  "terminalCursor": "#$bright7",
  "terminalSelection": "#$selection",
  "terminalScrollbar": "#$edge",
  "terminalScrollbarHover": "#$dim"
}
EOT
)
    tmp=$(mktemp ~/.t3/userdata/themes/apollo.json.XXXXXX)
    if jq -n --argjson colors "$t3_colors" --arg bg "#$bg" --arg accent "#$accent" \
        '{name: "Apollo", appearance: "dark", canvas: $bg, accent: $accent, colors: $colors, variants: {light: $colors}}' > "$tmp"; then
        mv "$tmp" ~/.t3/userdata/themes/apollo.json
    else
        rm -f "$tmp"
    fi
fi
