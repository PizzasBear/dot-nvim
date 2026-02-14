local keymap = require "keymap"

---@type LazyPluginSpec
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    keys = keymap.telescope,

    enabled = false and vim.version.range(">=0.10"):has(vim.version()),

    opts = {},
}
