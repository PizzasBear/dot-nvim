local M = {}

M.colorscheme = "kanagawa"

function M.setup(_)
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.smarttab = false
    vim.opt.relativenumber = true
    vim.opt.number = true
    vim.opt.list = true
    vim.opt.listchars = { tab = "» ", extends = ">", precedes = "<", nbsp = "·", trail = "·" }
    vim.opt.autoindent = true
    vim.opt.timeoutlen = 250 -- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
    vim.opt.encoding = "utf-8"
    vim.opt.scrolloff = 2
    vim.opt.showmode = true
    vim.opt.hidden = true
    vim.opt.joinspaces = false
    vim.opt.showcmd = true -- Show (partial) command in status line.
    vim.opt.mouse = "a" -- Enasle mouse usage (all modes) in terminals
    vim.opt.confirm = true
    vim.opt.dictionary:append "/usr/share/dict/words"

    -- HEBREW
    vim.opt.allowrevins = true

    -- -- Folding
    -- vim.opt.foldmethod = "expr"
    -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- function() require("nvim-treesitter.fold").get_fold_indic(vim.v.lnum) end
    -- vim.opt.foldenable = false

    -- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true
    vim.o.breakindentopt = "shift:4,min:40,sbr"
    vim.opt.showbreak = ">>"

    -- Assembly
    vim.g.asmsyntax = "nasm"
    vim.g.tex_flavor = "latex"

    -- Permanent undo
    vim.opt.undodir = vim.fs.normalize "~/.vimdid"
    vim.opt.undofile = true

    -- Don"t pass messages to |ins-completion-menu|.
    vim.opt.shortmess = vim.o.shortmess .. "c"

    -- Colors and syntax highlighting
    vim.opt.termguicolors = true
    vim.opt.background = "dark"

    vim.cmd "filetype plugin indent on"

    vim.opt.exrc = true
    -- -- Disable NetRW builtin file browser
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1
end

function M.lazy_setup(_)
    -- vim.cmd.colorscheme "tokyonight-night"
    vim.cmd.colorscheme(M.colorscheme)
end

return M
