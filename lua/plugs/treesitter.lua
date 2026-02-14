---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",

    enabled = vim.version.range(">=0.11"):has(vim.version()),

    opts = {},
}
