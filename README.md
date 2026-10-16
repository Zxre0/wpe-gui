# wpe-gui

A small wallpaper picker for [linux-wallpaperengine](https://github.com/Almamu/linux-wallpaperengine) on Hyprland, built for people coming from Wallpaper Engine on Windows or the KDE plugin.

- Thumbnail grid of your Steam Workshop wallpapers, with search and a scene/video/web filter
- Click a card to apply it to all monitors or one monitor
- Highlights the wallpaper that's currently playing
- Settings for mute, volume and FPS limit
- Start/stop button
- Your choices persist, so `wpe start` at login restores them

It has two parts:

| File | What it is |
| --- | --- |
| `wpe` | Bash CLI wrapper around `linux-wallpaperengine` (start / stop / list / set) |
| `wpe-gui` | GTK4 + libadwaita picker that drives `wpe` |

## Requirements

- Hyprland (`hyprctl` is used to list monitors)
- [Wallpaper Engine](https://store.steampowered.com/app/431960/) owned on Steam and installed (force Proton in its compatibility settings so Steam will download it). Subscribe to wallpapers on the Workshop and Steam downloads them.
- `linux-wallpaperengine` (Arch: `yay -S linux-wallpaperengine-git`)
- Python 3 with `python-gobject`, `gtk4` and `libadwaita`

The Steam library is auto-detected in `~/.local/share/Steam`, `~/.steam/steam` and the Flatpak Steam path. To override it, set `WPE_STEAM_DIR`.

## Install

```sh
git clone https://github.com/Zxre0/wpe-gui
cd wpe-gui
./install.sh        # symlinks wpe, wpe-gui and the .desktop entry into ~/.local
```

Start the wallpaper when Hyprland starts:

```ini
# hyprland.conf
exec-once = wpe start
bind = SUPER ALT, W, exec, wpe-gui
```

```lua
-- hyprland.lua
hl.on("hyprland.start", function() hl.exec_cmd("sleep 2 && wpe start") end)
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd("wpe-gui"))
```

## CLI

```sh
wpe list                     # id, type, title for every Workshop wallpaper
wpe set "lofi cafe"          # title substring or Workshop id; all monitors
wpe set 2370927443 DP-2      # one monitor
wpe stop | wpe start
```

## Config

Both files live in `~/.config/wpe/`:

- `screens`: one `MONITOR WORKSHOP_ID` per line
- `options`: shell variables, e.g.

  ```sh
  SILENT=1   # 0 to enable sound
  VOLUME=15
  FPS=60
  ```

The log goes to `~/.cache/wpe.log`.

## Notes

- `linux-wallpaperengine` draws on the `bottom` layer-shell layer, so it sits above daemons like swww/awww/hyprpaper. You can leave those running (for example, so HyDE's wallbash theming keeps working).
- The wallpaper pauses automatically while a window is fullscreen.
- Web wallpapers often don't render correctly in `linux-wallpaperengine`. Scene and video wallpapers work best.

## License

MIT, see [LICENSE](LICENSE).
