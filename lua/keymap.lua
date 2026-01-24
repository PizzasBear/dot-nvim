local M = {}

local keycode = vim.F.if_nil(vim.keycode, function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end)

function M.setup(_)
    vim.g.mapleader = keycode "<Space>"

    vim.keymap.set("n", ";", ":")
    vim.keymap.set({ "n", "x" }, "j", "gj")
    vim.keymap.set({ "n", "x" }, "k", "gk")

    vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { silent = true })

    vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
    vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious)
    vim.keymap.set("n", "<leader>bk", vim.cmd.bdelete)
    vim.keymap.set("n", "<leader>bl", vim.cmd.buffers)

    vim.keymap.set("n", "<leader>fs", vim.cmd.write)
    vim.keymap.set("n", "<leader>o-", vim.cmd.Explore)
    vim.keymap.set("n", "<leader>ot", vim.cmd.terminal)

    vim.keymap.set("n", "<leader>nh", vim.cmd.noh)
    vim.keymap.set("n", "<leader>w", "<c-w>", { remap = true })

    vim.keymap.set("i", "<CR>", function()
        local has_npairs, npairs = pcall(require, "nvim-autopairs")

        local cr = has_npairs and npairs.autopairs_cr or function()
            return keycode "<CR>"
        end

        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info({ "selected" }).selected ~= -1 then
                return keycode "<C-y>"
            else
                return keycode "<C-e>" .. cr()
            end
        else
            return cr()
        end
    end, { expr = true, replace_keycodes = false })
end

-- stylua: ignore
---@module 'lazy'
---@type LazyKeysSpec[]
M.telescope = {
    { mode = { "n" }, "<leader><leader>", function() require("telescope.builtin").find_files() end, desc = "Telescope find files" },
    { mode = { "n" }, "<leader>fg",       function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
    { mode = { "n" }, "<leader>/",        function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
    { mode = { "n" }, "gO",               function() require("telescope.builtin").lsp_document_symbols() end },
    { mode = { "n" }, "grr",              function() require("telescope.builtin").lsp_references() end },
    { mode = { "n" }, "<C-g>",            function() require("telescope.builtin").buffers() end },
    { mode = { "n" }, "<C-_>",            function() require("telescope.builtin").help_tags() end },
}

-- stylua: ignore
---@module 'lazy'
---@type LazyKeysSpec[]
M.flash = {
    { mode = { "n", "x", "o" }, "s",     function() require("flash").jump() end, desc = "Flash" },
    { mode = { "n", "x", "o" }, "S",     function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { mode = { "o" },           "r",     function() require("flash").remote() end, desc = "Remote Flash" },
    { mode = { "o", "x" },      "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { mode = { "c" },           "<c-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
}

-- stylua: ignore
---@module 'lazy'
---@type LazyKeysSpec[]
M.trouble = {
    { mode = { "n" }, "<leader>oe", function() require("trouble").toggle("diagnostics") end, desc = "Diagnostics (Trouble)" },
}

---@module 'blink.cmp'
---@type blink.cmp.KeymapConfig
M.blink = {
    preset = "enter",
    ["<c-n>"] = { "show", "select_next", "fallback_to_mappings" },
}

return M
