-- Replicated from Kun Chen's dotfiles-mac-nix (files/.config/wezterm/wezterm.lua).
local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = os.getenv("OS") and os.getenv("OS"):lower():find("windows")
local is_macos = wezterm.target_triple:lower():find("darwin") ~= nil

-- Default window size, matching Apple Terminal "MyPro" (150 cols x 60 rows).
config.initial_cols = 150
config.initial_rows = 60

-- Colors replicated from the Apple Terminal "MyPro" profile.
-- Values marked (default) were not overridden in MyPro, so they use
-- Apple Terminal's built-in default ANSI palette (what Terminal actually shows).
config.colors = {
  foreground = "#ffffff",
  background = "#424242",
  cursor_bg = "#00f900",
  cursor_fg = "#424242",
  cursor_border = "#00f900",
  selection_bg = "#b4d5fe",
  selection_fg = "#000000",
  ansi = {
    "#606060", -- black
    "#990000", -- red      (default)
    "#98fb98", -- green
    "#f0e68c", -- yellow
    "#cd853f", -- blue
    "#ffdead", -- magenta
    "#ffa0a0", -- cyan
    "#f5deb3", -- white
  },
  brights = {
    "#666666", -- bright black   (default)
    "#e50000", -- bright red     (default)
    "#00d900", -- bright green   (default)
    "#e5e500", -- bright yellow  (default)
    "#87ceeb", -- bright blue
    "#e500e5", -- bright magenta (default)
    "#ffd700", -- bright cyan
    "#efeef0", -- bright white
  },
}
config.max_fps = 120
-- Menlo Regular to match Apple Terminal "MyPro"; Hack Nerd Font as fallback
-- supplies the icon glyphs (neo-tree/devicons) that Menlo doesn't include.
-- Menlo Regular (matches Apple Terminal "MyPro"). Menlo has only Regular/Bold,
-- so the heavier look in Terminal comes from macOS font smoothing, replicated
-- here via `defaults write com.github.wez.wezterm AppleFontSmoothing -int 2`.
-- Hack Nerd Font fallback supplies icon glyphs.
config.font = wezterm.font_with_fallback({ "Menlo", "Hack Nerd Font" })
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  font = wezterm.font("Menlo", { weight = "Bold" }),
}
config.inactive_pane_hsb = {
  saturation = 0.0,
  brightness = 0.5,
}

if is_windows then
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.7
  config.window_frame.font_size = 10.0
end

if is_macos then
  config.window_background_opacity = 1.0   -- opaque, so colors match Apple Terminal exactly
  config.font_size = 12.0                  -- match Apple Terminal "MyPro"
  config.window_frame.font_size = 13.0
end

return config
