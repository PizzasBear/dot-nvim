local keymap = require "keymap"

---@module "lazy"
---@type LazyPluginSpec
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = keymap.trouble,
}
