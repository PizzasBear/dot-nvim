assert(vim.version.range(">=0.12"):has(vim.version()))

-- TODO: This plugin is now unmaintained, replace with a good alternative.
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd "nvim-treesitter"
            end
            vim.cmd.TSUpdate()
        end
    end,
})

vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }
require("nvim-treesitter").setup {}
