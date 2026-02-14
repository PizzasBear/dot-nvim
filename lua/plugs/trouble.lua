local keymap = require "keymap"

---@type LazyPluginSpec
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = keymap.trouble,
}
