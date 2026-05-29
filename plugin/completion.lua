local keymap = require "keymap"

assert(vim.version.range(">=0.10"):has(vim.version()))
vim.pack.add {
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1" },
}
require("blink.cmp").setup {
    keymap = keymap.blink,

    completion = { documentation = { auto_show = true } },
}
