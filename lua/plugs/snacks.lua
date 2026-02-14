local keymap = require "keymap"

---@type LazyPluginSpec
return {
    "folke/snacks.nvim",
    dependencies = {
        "nvim-mini/mini.icons",
    },
    keys = keymap.snacks,

    enabled = vim.version.range(">=0.9.4"):has(vim.version()),

    ---@type snacks.Config
    opts = {
        picker = {
            win = {
                input = {
                    keys = {
                        ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
                        ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {
                        ["<PageUp>"] = "list_scroll_up",
                        ["<PageDown>"] = "list_scroll_down",
                    },
                },
                preview = {
                    keys = {},
                },
            },
        },
        bigfile = {},
    },
}
