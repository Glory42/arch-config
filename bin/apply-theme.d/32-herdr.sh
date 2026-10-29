# herdr's theme, spliced between the markers in its tracked config.toml
if [ -f ~/.config/herdr/config.toml ] && grep -q '^# apply-theme:begin' ~/.config/herdr/config.toml; then
    block=$(cat <<EOT
# apply-theme:begin (generated from palette.json, do not edit down to the end marker)
[theme]
name = "terminal"
auto_switch = false

[theme.custom]
panel_bg = "#$bg"
sidebar_bg = "#$dark_bg"
surface_dim = "#$dark_bg"
active_row_bg = "#$(mix "$dark_bg" "$accent" 18)"
selection_bg = "#$selection"
accent = "#$accent"
red = "#$red"
green = "#$green"
yellow = "#$yellow"
peach = "#$bright1"
mauve = "#$magenta"
# apply-theme:end
EOT
)
    tmp=$(mktemp)
    awk -v block="$block" '
        /^# apply-theme:begin/ { print block; skip = 1; next }
        /^# apply-theme:end/   { skip = 0; next }
        !skip
    ' ~/.config/herdr/config.toml > "$tmp" && cat "$tmp" > ~/.config/herdr/config.toml; rm -f "$tmp"
    herdr server reload-config >/dev/null 2>&1 || true
fi
