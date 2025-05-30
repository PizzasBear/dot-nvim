return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("kanagawa").setup(opts)
            -- vim.cmd("colorscheme kanagawa-wave")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd "colorscheme tokyonight-night"
        end,
    },
}
