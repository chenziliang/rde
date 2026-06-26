-- Entry point. Loads options, keymaps, then bootstraps lazy.nvim + plugins.
-- Philosophy: terminal-centered, low visual clutter, fast grep/fzf, few plugins.
require("config.options")
require("config.keymaps")
require("config.from-vimrc")
require("config.lazy")
