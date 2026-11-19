# Arch Linux Dotfiles

Personal **Arch Linux** X11 desktop environment built around custom-patched [suckless](https://suckless.org/) utilities, dynamic [pywal](https://github.com/dylanaraps/pywal) theming via `Xresources`, [picom](https://github.com/yshui/picom) compositing, and a modular [Neovim](https://neovim.io/) setup. Managed directly in `$HOME` via a bare Git repository (`~/.dotfiles`).

---

## Suckless Builds (`~/.local/src/`)

### [dwm](https://dwm.suckless.org/) (`v6.8`)
Dynamic window manager configured with per-client layout weights, gaps, transparency, clickable status blocks, and a system tray.
* **Applied Patches (`patches/`):**
  * [alpha](https://dwm.suckless.org/patches/alpha/) (`dwm-alpha-20250918-74edc27.diff`) — True ARGB transparency for the status bar.
  * [autostart](https://dwm.suckless.org/patches/autostart/) (`dwm-autostart-20161205-bb3bd6f.diff`) — Runs `~/.dwm/autostart_blocking.sh` and `~/.dwm/autostart.sh` on startup.
  * [cfacts](https://dwm.suckless.org/patches/cfacts/) + [vanitygaps](https://dwm.suckless.org/patches/vanitygaps/) (`dwm-cfacts-vanitygaps-6.4_combo.diff`) — Adjustable client size weights in the stack area alongside configurable inner/outer gaps.
  * [statuscmd](https://dwm.suckless.org/patches/statuscmd/) (`dwm-statuscmd-20260124-a9aa0d8.diff`) — Forwards mouse button clicks on status bar modules via signals to `dwmblocks-async`.
  * [systray](https://dwm.suckless.org/patches/systray/) (`dwm-systray-20260516-44dbc68.diff`) — Embedded X11 system tray in the bar.
* **Custom C Modifications (`dwm.c` / `config.h`):**
  * Whitelisted `X_ReparentWindow` `BadMatch` errors inside `xerror()` so depth mismatches between the 32-bit ARGB bar (`alpha`) and 24-bit tray icons (e.g., Qt6/qBittorrent) do not terminate the X11 session.
  * Custom keybindings including `Mod + Shift + X` for screen locking (`slock`).

### [st](https://st.suckless.org/) (`v0.9.3`)
Simple terminal configured for transparency, scrollback history, crisp box rendering, and live `pywal` color reloading.
* **Applied Patches:**
  * [alpha](https://st.suckless.org/patches/alpha/) (`st-alpha-20240814-a0274bc.diff`) — Background opacity support paired with `picom`.
  * [boxdraw](https://st.suckless.org/patches/boxdraw/) (`st-boxdraw_v2-0.8.5.diff`) — Custom pixel-aligned rendering of Unicode box-drawing and block characters.
  * [scrollback](https://st.suckless.org/patches/scrollback/) & [scrollback-mouse](https://st.suckless.org/patches/scrollback/) (`st-scrollback-0.9.2.diff`, `st-scrollback-mouse-0.9.2.diff`) — Terminal scrollback buffer with keyboard and mouse-wheel navigation.
  * [xresources](https://st.suckless.org/patches/xresources/) (`st-xresources-20260524-688f70a.diff`) — Runtime color and font configuration loaded from `Xresources` / `pywal`.

### [dmenu](https://tools.suckless.org/dmenu/) (`v5.4`)
Centered, bordered application launcher with fuzzy search and dynamic `Xresources` theming.
* **Applied Patches:**
  * [border](https://tools.suckless.org/dmenu/patches/border/) (`dmenu-border-20230512-0fe460d.diff`) — Draws a configurable border around the `dmenu` window.
  * [center](https://tools.suckless.org/dmenu/patches/center/) (`dmenu-center-20250407-b1e217b.diff`) — Centers `dmenu` on screen instead of pinning to the top edge.
  * [fuzzymatch](https://tools.suckless.org/dmenu/patches/fuzzymatch/) (`dmenu-fuzzymatch-5.3.diff`) — Non-contiguous fuzzy string matching for entries.
  * [xresources](https://tools.suckless.org/dmenu/patches/xresources/) (`dmenu-xresources-20260510-7175c48.diff`) — Pulls colors dynamically from `Xresources` / `pywal`.

### [slock](https://tools.suckless.org/slock/) (`v1.7` via [slock-flexipatch](https://github.com/bakkeby/slock-flexipatch))
Screen locker compiled with modular flexipatch toggles.
* **Enabled Patches (`patches.h`):**
  * `ALPHA_PATCH` ([alpha](https://tools.suckless.org/slock/patches/alpha/)) — Translucent lock screen overlay.
  * `DWM_LOGO_PATCH` ([dwmlogo](https://tools.suckless.org/slock/patches/dwmlogo/)) — Renders a centered geometric `dwm` logo that shifts color on input/failure.
  * `MESSAGE_PATCH` & `COLOR_MESSAGE_PATCH` ([message](https://tools.suckless.org/slock/patches/message/) / [colormessage](https://tools.suckless.org/slock/patches/colormessage/)) — Displays colored custom status messages (`-m`) on the lock screen.
* **Arch-Specific Tweaks:** Privilege drop group configured to `nobody` and bitmap font set to `6x13` (`xorg-fonts-misc`).

### [dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async)
Asynchronous, non-blocking status bar daemon for `dwm` (`blocks.h` / `config.h`) supporting per-module intervals, signals, and `$BLOCK_BUTTON` click actions.

---

## Scripts & Desktop Utilities

### Custom Scripts (`~/.local/bin/`)
* **Status Bar Modules:** `dwmblocks-bat`, `dwmblocks-date`, `dwmblocks-mem`, `dwmblocks-vol`, `dwmblocks-wifi` — Modular shell scripts feeding `dwmblocks-async` with click-event handlers.
* **`setbg`:** Wallpaper setter that generates and reloads a matching system-wide color scheme via [pywal](https://github.com/dylanaraps/pywal) across `st`, `dmenu`, and X11.
* **`screenshot.sh`:** Screen capture utility for full-screen and region screenshots.

### Compositor & X11 (`~/.config/picom/`, `~/.xinitrc`, `~/.xprofile`, `~/.zshrc`)
* **[picom](https://github.com/yshui/picom) (`~/.config/picom/picom.conf`):** Handles window transparency (`st` and `dwm` bar alpha), shadows, and fading.
* **X11 Session (`~/.xinitrc`, `~/.xprofile`):** Registers `/usr/share/fonts/misc` in the Xorg font path (`xset +fp`), initializes background daemons, and logs `dwm` `stderr` to `~/.dwm.log`.

---

## [Neovim](https://neovim.io/) (`~/.config/nvim/`)

Modular Lua configuration split into `lua/config/` (`options.lua`, `remap.lua`, `lazy.lua`) and `lua/plugins/`:
* **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) (`lazy-lock.json` tracked for reproducible versions).
* **Colorscheme:** [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) (`contrast = "hard"` with high-visibility comment and line-number overrides).
* **LSP & Syntax:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason.nvim](https://github.com/williamboman/mason.nvim) (`clangd`, `lua_ls`, `bashls`) and [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
* **Navigation & Git:** [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), [harpoon](https://github.com/ThePrimeagen/harpoon), [vim-fugitive](https://github.com/tpope/vim-fugitive), [undotree](https://github.com/mbbill/undotree), and [vim-be-good](https://github.com/ThePrimeagen/vim-be-good).

---

## Repository Usage

Tracked with a bare Git repository aliased to `dotfiles`:

```bash
# Check status of tracked configs
dotfiles status

# Stage, commit, and push modifications
dotfiles add -u
dotfiles commit -m "Update configuration"
dotfiles push
