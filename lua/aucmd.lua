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
        pattern = { "*.gd" },
        callback = function(ev)
            vim.bo[ev.buf].filetype = "gdscript"
        end,
    })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(ev)
            if vim.bo[ev.buf].filetype == "htmldjango" then
                require("luasnip.loaders.from_vscode").load {
                    include = { "html" },
                }
            end
        end,
    })
end

local function format_on_save()
    local group = vim.api.nvim_create_augroup("FormatOnSave", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        callback = function()
            vim.cmd.FormatWrite()
        end,
    })
end

function M.setup(_)
    detect_files()
    format_on_save()
end

return M
