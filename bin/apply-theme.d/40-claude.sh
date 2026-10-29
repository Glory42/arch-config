# Claude Code's custom:apollo theme, chosen in its settings.json when no theme is set
mkdir -p ~/.claude/themes
cat > ~/.claude/themes/apollo.json <<EOT
{
  "name": "Apollo",
  "base": "dark",
  "overrides": {
    "claude": "#$accent",
    "claudeShimmer": "#$(mix "$accent" "$fg" 35)",
    "text": "#$fg",
    "inverseText": "#$bg",
    "inactive": "#$(mix "$fg" "$bg" 40)",
    "inactiveShimmer": "#$(mix "$fg" "$bg" 25)",
    "subtle": "#$dim",
    "suggestion": "#$cyan",
    "permission": "#$blue",
    "permissionShimmer": "#$(mix "$blue" "$fg" 35)",
    "remember": "#$yellow",
    "success": "#$green",
    "error": "#$red",
    "warning": "#$yellow",
    "warningShimmer": "#$(mix "$yellow" "$fg" 35)",
    "merged": "#$magenta",
    "promptBorder": "#$accent",
    "promptBorderShimmer": "#$(mix "$accent" "$fg" 35)",
    "planMode": "#$cyan",
    "autoAccept": "#$yellow",
    "bashBorder": "#$bright3",
    "ide": "#$bright6",
    "diffAdded": "#$(mix "$bg" "$green" 15)",
    "diffRemoved": "#$(mix "$bg" "$red" 15)",
    "diffAddedDimmed": "#$(mix "$bg" "$green" 8)",
    "diffRemovedDimmed": "#$(mix "$bg" "$red" 8)",
    "diffAddedWord": "#$(mix "$bg" "$green" 32)",
    "diffRemovedWord": "#$(mix "$bg" "$red" 32)",
    "userMessageBackground": "#$(mix "$bg" "$fg" 6)",
    "userMessageBackgroundHover": "#$(mix "$bg" "$fg" 10)",
    "bashMessageBackgroundColor": "#$(mix "$bg" "$fg" 6)",
    "memoryBackgroundColor": "#$(mix "$bg" "$fg" 6)",
    "selectionBg": "#$selection",
    "rate_limit_fill": "#$accent",
    "rate_limit_empty": "#$(mix "$bg" "$fg" 20)",
    "briefLabelYou": "#$yellow",
    "briefLabelClaude": "#$accent"
  }
}
EOT
if [ ! -f ~/.claude/settings.json ]; then
    echo '{ "theme": "custom:apollo" }' > ~/.claude/settings.json
elif [ "$(jq -r '.theme // empty' ~/.claude/settings.json 2>/dev/null)" = "" ]; then
    tmp=$(mktemp) && jq '.theme = "custom:apollo"' ~/.claude/settings.json > "$tmp" && mv "$tmp" ~/.claude/settings.json
fi
