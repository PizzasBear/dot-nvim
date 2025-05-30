return {
    "nvim-lspconfig",
    config = function()
        vim.lsp.enable "bashls"
        vim.lsp.enable "cssls"
        vim.lsp.enable "clangd"
        vim.lsp.enable "gdscript"
        vim.lsp.enable "gopls"
        vim.lsp.config("html", {
            filetypes = { "html", "htmldjango" },
        })
        vim.lsp.enable "html"
        vim.lsp.enable "jsonls"
        vim.lsp.config("lua_ls", {
            Lua = {
                format = { enable = false },
            },
        })
        vim.lsp.enable "lua_ls"
        vim.lsp.enable "marksman"
        vim.lsp.config("omnisharp", {
            cmd = { "OmniSharp" },
            organize_imports_on_format = true,
            -- handlers = {
            --     ["textDocument/definition"] = require("omnisharp_extended").handler,
            -- },
        })
        vim.lsp.enable "omnisharp"
        vim.lsp.enable "pyright"
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = { disabled = { "remove-unnecessary-else" } },
                    -- cargo = {
                    --     features = "all",
                    -- },
                },
            },
        })
        vim.lsp.enable "rust_analyzer"
        vim.lsp.enable "taplo"
        vim.lsp.enable "templ"
        vim.lsp.enable "texlab"
        vim.lsp.enable "ts_ls"
        vim.lsp.config("unocss", {
            filetypes = {
                "html",
                "htmldjango",
                "javascriptreact",
                "rescript",
                "typescriptreact",
                "vue",
                "svelte",
                "rust",
            },
        })
        vim.lsp.enable "unocss"
        vim.lsp.enable "vimls"
        vim.lsp.enable "wgsl_analyzer"
        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    schemas = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                        ["/path/from/root/of/project"] = "/.github/workflows/*",
                    },
                },
            },
        })
        vim.lsp.enable "yamlls"
        vim.lsp.enable "zls"
    end,
}
