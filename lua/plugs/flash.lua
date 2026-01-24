local keymap = require "keymap"

---@module "lazy"
---@type LazyPluginSpec
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = keymap.flash,
}
