local keymap = require "keymap"

-- Depends on: https://github.com/nvim-tree/nvim-web-devicons
vim.pack.add { "https://github.com/folke/trouble.nvim" }
require("trouble").setup {}
keymap.apply(keymap.trouble)
