local keymap = require "keymap"

---@type LazyPluginSpec
return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },

    enabled = vim.version.range(">=0.10"):has(vim.version()),

    ---@type blink.cmp.Config
    opts = {
        keymap = keymap.blink,

        completion = { documentation = { auto_show = true } },
    },
}
