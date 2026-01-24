local M = {}

local function detect_files()
    local group = vim.api.nvim_create_augroup("DetectFiles", {})
    local mappings = {
        { pattern = { ".clangd", ".prettierrc" }, filetype = "yaml" },
        { pattern = { ".djlintrc" }, filetype = "json" },
        { pattern = { ".prettierignore" }, filetype = "gitignore" },
        { pattern = { "tmux.conf.local" }, filetype = "tmux" },
        { pattern = { "*.rasi" }, filetype = "rasi" },
        { pattern = { "*.asm", "*.S" }, filetype = "asm" },
        { pattern = { "*.v" }, filetype = "verilog" },
        { pattern = { "*.gd" }, filetype = "gdscript" },
        { pattern = { "*.html.j2" }, filetype = "htmldjango" },
    }
    for _, mapping in ipairs(mappings) do
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            group = group,
            pattern = mapping.pattern,
            callback = function(ev)
                vim.bo[ev.buf].filetype = mapping.filetype
            end,
        })
    end
end

function M.setup(_)
    detect_files()

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        callback = function(ev)
            pcall(vim.treesitter.start, ev.buf)
        end,
    })

    local group = vim.api.nvim_create_augroup("FormatOnSave", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function(ev)
            if not vim.F.if_nil(vim.b[ev.buf].auto_format, vim.g.auto_format) then
                return
            end

            local status, conform = pcall(require, "conform")
            if status then
                conform.format { bufnr = ev.buf, quiet = true, timeout_ms = 3000, lsp_format = "fallback" }
            else
                vim.lsp.buf.format { bufnr = ev.buf, timeout_ms = 3000 }
            end
        end,
    })
end

return M
