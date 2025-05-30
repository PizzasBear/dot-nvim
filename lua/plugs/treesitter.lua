return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    opts = {},
    build = vim.cmd.TSUpdate,
}
