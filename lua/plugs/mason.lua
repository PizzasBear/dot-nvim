---@type LazyPluginSpec
return {
    "mason-org/mason.nvim",

    enabled = vim.version.range(">=0.10"):has(vim.version()),

    ---@class MasonSettings
    opts = {},
}
