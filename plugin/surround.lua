vim.pack.add { "https://github.com/nvim-mini/mini.surround" }
require("mini.surround").setup {
    -- Number of lines within which surrounding is searched
    n_lines = 300,
}
