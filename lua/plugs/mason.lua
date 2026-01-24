---@module "lazy"
---@type LazyPluginSpec
return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "nvim-lspconfig",
    },

    enabled = vim.version.range(">=0.11"):has(vim.version()),

    opts = {},
}
