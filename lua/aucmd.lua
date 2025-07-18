local M = {}

local function detect_files()
    local group = vim.api.nvim_create_augroup("DetectFiles", {})
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { ".clangd", ".prettierrc" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "yaml"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { ".djlintrc" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "json"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { ".prettierignore" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "gitignore"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "tmux.conf.local" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "tmux"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "*.rasi" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "rasi"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "*.asm", "*.S" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "asm"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "*.v" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "verilog"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "*.gd" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "gdscript"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = { "*.html.j2" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "htmldjango"
        end,
    })
    -- vim.api.nvim_create_autocmd("FileType", {
    --     group = group,
    --     callback = function(ev)
    --         if vim.bo[ev.buf].filetype == "htmldjango" then
    --             require("luasnip.loaders.from_vscode").load {
    --                 include = { "html" },
    --             }
    --         end
    --     end,
    -- })
end

function M.setup(_)
    detect_files()

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        callback = function(ev)
            pcall(vim.treesitter.start, ev.buf)
        end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client:supports_method "textDocument/completion" then
                vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            end
        end,
    })

    vim.api.nvim_create_autocmd("InsertCharPre", {
        callback = function()
            if vim.fn.pumvisible() ~= 0 or vim.fn.state "m" == "m" then
                return
            end
            if vim.v.char:match "^[_%a]$" then
                vim.lsp.completion.get()
            end
        end,
    })

    local group = vim.api.nvim_create_augroup("FormatOnSave", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function(ev)
            local status, conform = pcall(require, "conform")
            if status then
                conform.format { bufnr = ev.buf }
            else
                vim.lsp.buf.format { bufnr = ev.buf }
            end
        end,
    })
end

return M
