#!/bin/bash
set -e
DOTS="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -eq 0 ]; then
    echo "run this as your normal user, it asks for sudo by itself"
    exit 1
fi

link() {
    if [ -e "$2" ] && [ ! -L "$2" ]; then
        mv "$2" "$2.bak.$(date +%s)"
    fi
    ln -sfn "$1" "$2"
}

pkgs() { grep -vE '^\s*(#|$)' "$1" | sed 's/[[:space:]]*#.*//'; }
say() { echo; echo "==> $*"; }

say "installing packages: this is a good time to make tea"
sudo pacman -S --needed $(pkgs "$DOTS/packages/pacman.txt")

if ! command -v yay >/dev/null 2>&1; then
    say "no yay, so building the thing that builds things"
    sudo pacman -S --needed git base-devel
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
    (cd "$tmp/yay-bin" && makepkg -si)
    rm -rf "$tmp"
fi

say "now the AUR, where strangers write the packages and we install them anyway"
curl -fsS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.gpg | gpg --import - \
    || echo "could not fetch the Spotify signing key: the spotify package may refuse to build"
yay -S --needed $(pkgs "$DOTS/packages/aur.txt") \
    || echo "some AUR packages did not install: the rest of the setup goes on, run yay -S --needed again for them later"

say "teaching the system its manners: iwd for Wi-Fi, a power button that waits for Apollo, services, the docker group"
sudo mkdir -p /etc/NetworkManager/conf.d /etc/systemd/logind.conf.d
printf '[device]\nwifi.backend=iwd\n' | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null
printf '[Login]\nHandlePowerKey=ignore\n' | sudo tee /etc/systemd/logind.conf.d/10-ignore-power-button.conf >/dev/null
sudo systemctl enable NetworkManager.service bluetooth.service cups.socket docker.socket ufw.service paccache.timer ly@tty1.service
sudo usermod -aG docker "$USER"

say "symlinking everything, so deleting this folder later will be a dramatic act"
mkdir -p ~/.config ~/.local
for d in hypr theme foot nvim zed gtk-3.0 gtk-4.0 fastfetch imv; do
    link "$DOTS/$d" ~/.config/$d
done

[ -L ~/.local/bin ] && rm ~/.local/bin
mkdir -p ~/.local/bin
for f in "$DOTS"/bin/*; do
    ln -sfn "$f" ~/.local/bin/"$(basename "$f")"
done

mkdir -p ~/.config/uwsm
grep -qs '\.local/bin' ~/.config/uwsm/env || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/uwsm/env
grep -qs 'mise/shims' ~/.config/uwsm/env || echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.config/uwsm/env

mkdir -p ~/.config/herdr
link "$DOTS/herdr/config.toml" ~/.config/herdr/config.toml

if [ ! -d ~/.local/share/icons/Banana ]; then
    say "fetching a banana cursor. yes, a banana. it was a choice"
    mkdir -p ~/.local/share/icons
    curl -fsSL https://github.com/dreamsofautonomy/banana-cursor/releases/download/v2.2.0/Banana.tar.xz | tar -xJ -C ~/.local/share/icons
fi

link "$DOTS/spotify/spotify-flags.conf" ~/.config/spotify-flags.conf

link "$DOTS/starship/starship.toml" ~/.config/starship.toml

mkdir -p ~/.config/cava
link "$DOTS/cava/config" ~/.config/cava/config

mkdir -p ~/.config/vesktop/settings
link "$DOTS/vesktop/themes" ~/.config/vesktop/themes
link "$DOTS/vesktop/quickCss.css" ~/.config/vesktop/settings/quickCss.css

say "cloning Apollo, the part of this that actually does the work"
[ -d ~/Projects/apollo-qml ] || git clone git@github.com:Glory42/apollo-qml.git ~/Projects/apollo-qml
link ~/Projects/apollo-qml ~/.config/quickshell

say "fetching the wallpapers, the heaviest part of a config with no code"
[ -d ~/Projects/wallpapers ] || git clone git@github.com:Glory42/wallpapers.git ~/Projects/wallpapers \
    || echo "could not clone the wallpapers repo: themes will have no pictures until ~/Projects/wallpapers exists"
for t in "$DOTS"/theme/themes/*/; do
    name=$(basename "$t")
    [ -d ~/Projects/wallpapers/"$name" ] && link ~/Projects/wallpapers/"$name" "$t/wallpapers"
done

echo 'foot.desktop' > ~/.config/xdg-terminals.list

say "painting everything in one colour, as is tradition"
"$DOTS/bin/apply-theme" || echo "apply-theme did not finish cleanly: run it again after logging in"
"$DOTS/bin/apply-appearance" || echo "apply-appearance did not finish cleanly: run it again after logging in"

say "done: log out and back in, then pretend it always looked this good"
