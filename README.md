# arch-config

My Arch setup: Hyprland, a pile of Lua, and one colour palette that repaints everything at once, whether the apps like it or not.

The bar, launcher and lock screen live in [Apollo](https://github.com/Glory42/apollo-qml), a separate repo, because one repo was not enough commitment.

## Install

```bash
git clone git@github.com:Glory42/arch-config.git ~/Projects/hyprland-dots
~/Projects/hyprland-dots/install.sh
```

It installs the packages, links the configs into `~/.config` and clones Apollo. Log out and back in afterwards, then run `apply-theme` once.

The wallpapers live in yet another repo, because apparently nothing here is allowed to share a folder. The script clones that too.

## Warranty

It works on my machine. Yours is a different machine, so good luck. If something is bad, it is because I am either stupid or lazy, and I will not say which.
