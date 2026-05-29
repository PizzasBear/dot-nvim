local keymap = require "keymap"

vim.pack.add { "https://github.com/folke/flash.nvim" }
require("flash").setup {}
keymap.apply(keymap.flash)
