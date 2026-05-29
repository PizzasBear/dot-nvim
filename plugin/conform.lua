assert(vim.version.range(">=0.10"):has(vim.version()))

vim.pack.add { "https://github.com/stevearc/conform.nvim" }

require("conform").setup {
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
        javascript = { "deno_fmt" },
        javascriptreact = { "deno_fmt" },
        typescript = { "deno_fmt" },
        typescriptreact = { "deno_fmt" },
        vue = { "prettier" },
        css = { "deno_fmt" },
        scss = { "deno_fmt" },
        less = { "deno_fmt" },
        html = { "deno_fmt" },
        json = { "deno_fmt" },
        jsonc = { "deno_fmt" },
        yaml = { "deno_fmt" },
        markdown = { "deno_fmt" },
        ["markdown.mdx"] = { "prettier" },
        graphql = { "biome" },
        handlebars = { "prettier" },
        svelte = { "prettier" },
        astro = { "prettier" },
        htmlangular = { "prettier" },
        xml = { "deno_fmt" },
    },
}
