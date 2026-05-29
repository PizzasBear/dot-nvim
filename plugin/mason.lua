assert(vim.version.range(">=0.10"):has(vim.version()))

vim.pack.add { "https://github.com/mason-org/mason.nvim" }
require("mason").setup {}
