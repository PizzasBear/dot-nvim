local keymap = require "keymap"

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = keymap.telescope,
}
