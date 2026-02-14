local keymap = require "keymap"

---@type LazyPluginSpec
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = keymap.flash,
}
