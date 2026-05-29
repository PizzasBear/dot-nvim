local keymap = require "keymap"

assert(vim.version.range(">=0.9.4"):has(vim.version()))
vim.pack.add { "https://github.com/folke/snacks.nvim" }
require("snacks").setup {
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
}
keymap.apply(keymap.snacks)
