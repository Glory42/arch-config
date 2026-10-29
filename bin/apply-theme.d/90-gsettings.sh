# GTK apps told to reread their colours by flipping the colour scheme, and an idle Nautilus closed so it starts fresh
mkdir -p ~/.cache
log=~/.cache/apply-theme.log
if command -v gsettings >/dev/null 2>&1; then
    schema=org.gnome.desktop.interface
    scheme=$(gsettings get $schema color-scheme 2>/dev/null); scheme=${scheme//\'/}
    [ -n "$scheme" ] || scheme=prefer-dark
    if [ "$scheme" = prefer-dark ]; then other=default; else other=prefer-dark; fi
    gtk_theme=$(gsettings get $schema gtk-theme 2>/dev/null); gtk_theme=${gtk_theme//\'/}

    gsettings set $schema color-scheme "$other" 2>/dev/null; r1=$?
    sleep 0.4
    gsettings set $schema color-scheme "$scheme" 2>/dev/null; r2=$?

    if [ -n "$gtk_theme" ]; then
        gsettings set $schema gtk-theme "" 2>/dev/null
        sleep 0.3
        gsettings set $schema gtk-theme "$gtk_theme" 2>/dev/null
    fi
fi

windows=unknown
if command -v hyprctl >/dev/null 2>&1; then
    windows=$(hyprctl clients -j 2>/dev/null | jq '[.[] | select(.class == "org.gnome.Nautilus")] | length' 2>/dev/null)
fi
closed=no
if pgrep -x nautilus >/dev/null 2>&1 && [ "$windows" = 0 ]; then
    nautilus -q >/dev/null 2>&1
    closed=yes
fi

echo "$(date +%T) scheme=$scheme flipped-via=${other:-none} gsettings=${r1:-?}/${r2:-?} nautilus-windows=$windows idle-nautilus-closed=$closed" > "$log"
