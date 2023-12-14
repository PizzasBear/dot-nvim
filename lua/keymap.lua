local M = {}

function M.setup(_)
    vim.g.mapleader = " "

    vim.keymap.set("n", ";", ":")
    vim.keymap.set("n", "j", "gj")
    vim.keymap.set("n", "k", "gk")

    vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { silent = true })

    vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
    vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious)
    vim.keymap.set("n", "<leader>bk", vim.cmd.bdelete)
    vim.keymap.set("n", "<leader>bl", vim.cmd.buffers)

    vim.keymap.set("n", "<leader>fs", vim.cmd.write)
    vim.keymap.set("n", "<leader>o-", vim.cmd.Explore)
    vim.keymap.set("n", "<leader>ou", vim.cmd.UndotreeToggle)

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

    vim.keymap.set("n", "<leader>nh", vim.cmd.noh)

    vim.keymap.set("n", "<leader>w", "<c-w>", { remap = true })
end

function M.setup_telescope(_)
    local builtin = require "telescope.builtin"

    vim.keymap.set("n", "<leader><leader>", builtin.find_files)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    -- vim.keymap.set("n", "gd", builtin.lsp_definitions)
    vim.keymap.set("n", "gr", builtin.lsp_references)
    vim.keymap.set("n", "<c-g>", builtin.buffers)
    vim.keymap.set("n", "<c-_>", builtin.help_tags)
end

function M.setup_nvim_tree(_)
    local api = require "nvim-tree.api"

    vim.keymap.set("n", "<leader>t", api.tree.toggle)
    vim.keymap.set("n", "<leader>tf", api.tree.focus)
    vim.keymap.set("n", "<c-f>", function()
        api.tree.find_file(vim.api.nvim_buf_get_name(0))
    end)
    vim.keymap.set("n", "<leader>tc", api.tree.collapse_all)
end

function M.cmp_mapping(lspz, cmp, _)
    return lspz.defaults.cmp_mappings {
        ["<cr>"] = cmp.mapping.confirm { select = true },
    }
end

function M.setup_dap(_)
    local dap = require "dap"

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dq", dap.terminate)
    vim.keymap.set("n", "<leader>dr", dap.continue)
    vim.keymap.set("n", "<leader>do", dap.step_out)
    vim.keymap.set("n", "<leader>ds", dap.step_over)
    vim.keymap.set("n", "<leader>di", dap.step_into)

    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<S-F5>", dap.terminate)
    vim.keymap.set("n", "<F9>", dap.step_out)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
end

function M.setup_toggleterm(_)
    vim.keymap.set("n", "<leader>ot", [[<cmd>execute v:count . "ToggleTerm"<cr>]])
    -- vim.keymap.set({ "n", "i" }, "<c-q>", [[<cmd>execute v:count . "ToggleTerm"<cr>]])
    vim.keymap.set("t", "<esc><c-q>", vim.cmd.ToggleTerm)
end

function M.setup_trouble(_)
    vim.keymap.set("n", "<leader>oe", vim.cmd.TroubleToggle)
end

-- local function buffer_lsp_setup(opts)
--     local bufopts = { buffer = opts.bufnr }
--
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
--     vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
--     vim.keymap.set("n", "ne", vim.diagnostic.goto_next, bufopts)
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
--     vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
--     vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
--     vim.keymap.set({ "i", "n" }, "<f2>", vim.lsp.buf.rename, bufopts)
--     vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
--     vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, bufopts)
--     vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
--     vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
-- end

return M
