---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",

    enabled = vim.version.range(">=0.10"):has(vim.version()),

    ---@type conform.setupOpts
    opts = {
        default_format_opts = {
            timeout_ms = 3000,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
        },
        formatters = {
            ["aosp-java-format"] = {
                meta = {
                    url = "https://github.com/google/google-java-format",
                    description = "Reformats Java source code according to Google Java Style.",
                },
                command = "google-java-format",
                args = { "--aosp", "-" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            luau = { "stylua" },
            fish = { "fish_indent" },
            python = { "ruff_organize_imports", "ruff_format" },
            java = { "clang-format" },

            sh = { "shfmt" },
            bash = { "shfmt" },
            zsh = { "shfmt" },

            -- prettier
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            vue = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            ["markdown.mdx"] = { "prettier" },
            graphql = { "prettier" },
            handlebars = { "prettier" },
            svelte = { "prettier" },
            astro = { "prettier" },
            htmlangular = { "prettier" },
            xml = { "prettier" },
        },
    },
}
