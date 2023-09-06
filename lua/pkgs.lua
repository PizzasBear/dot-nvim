local keymap = require "keymap"
local sets = require "sets"

local M = {}

local function install_lazy()
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)
end

function M.setup(_)
    install_lazy()

    require("lazy").setup({
        "mbbill/undotree",
        {
            "williamboman/mason.nvim",
            opts = {},
        },
        {
            "folke/neodev.nvim",
            opts = {},
        },
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            dependencies = {
                -- ordering
                "folke/neodev.nvim",

                -- LSP Support
                "neovim/nvim-lspconfig", -- Req
                "williamboman/mason.nvim", -- Opt
                "williamboman/mason-lspconfig.nvim", -- Opt

                -- Autocompletion
                "hrsh7th/nvim-cmp", -- Req
                "hrsh7th/cmp-nvim-lsp", -- Req
                "hrsh7th/cmp-buffer", -- Opt
                "hrsh7th/cmp-path", -- Opt
                "saadparwaiz1/cmp_luasnip", -- Opt
                "hrsh7th/cmp-nvim-lua", -- Opt

                -- Snippets
                "L3MON4D3/LuaSnip", -- Req
                "rafamadriz/friendly-snippets", -- Opt
            },
            config = function()
                local lspz = require("lsp-zero").preset "recommended"
                lspz.on_attach(function(client, bufnr)
                    local formatter_config = require "formatter.config"
                    local star_formatters = formatter_config.formatters_for_filetype()
                    local buf_formatters = formatter_config.formatters_for_filetype(vim.bo[bufnr].filetype)
                    if #star_formatters == #buf_formatters then
                        lspz.async_autoformat(client, bufnr)
                    end
                end)

                local cmp = require "cmp"
                lspz.setup_nvim_cmp {
                    select_behavior = "insert",
                    mapping = keymap.cmp_mapping(lspz, cmp),
                }

                require("luasnip.loaders.from_vscode").lazy_load()

                local lspc = require "lspconfig"

                lspc.bashls.setup {}
                lspc.clangd.setup {}
                lspc.gdscript.setup {}
                lspc.gopls.setup {}
                lspc.html.setup {
                    filetypes = { "html", "htmldjango" },
                }
                lspc.jsonls.setup {}
                lspc.lua_ls.setup {
                    Lua = {
                        format = { enable = false },
                    },
                }
                lspc.marksman.setup {}
                lspc.omnisharp.setup {
                    cmd = { "OmniSharp" },
                    organize_imports_on_format = true,
                }
                lspc.pyright.setup {}
                lspc.rust_analyzer.setup {}
                lspc.taplo.setup {}
                lspc.texlab.setup {}
                lspc.tsserver.setup {}
                lspc.vimls.setup {}
                lspc.yamlls.setup {
                    settings = {
                        yaml = {
                            schemas = {
                                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                                ["/path/from/root/of/project"] = "/.github/workflows/*",
                            },
                        },
                    },
                }
                lspc.zls.setup {}

                lspz.ensure_installed { "lua_ls", "clangd", "pyright", "rust_analyzer" }
                lspz.setup()
            end,
        },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {},
            config = function(_, opts)
                require("trouble").setup(opts)
                keymap.setup_trouble {}
            end,
        },
        {
            "mhartington/formatter.nvim",
            opts = function()
                local python = require "formatter.filetypes.python"
                local prettier = require "formatter.defaults.prettier"
                return {
                    filetype = {
                        lua = { require("formatter.filetypes.lua").stylua },
                        python = { python.isort, python.black },
                        sh = { require("formatter.filetypes.sh").shfmt },
                        sql = { require("formatter.filetypes.sql").pgformat },
                        javascript = { prettier },
                        typescript = { prettier },
                        javascriptreact = { prettier },
                        typescriptreact = { prettier },
                        html = { prettier },
                        css = { prettier },
                        json = { prettier },
                        yaml = { prettier },
                        htmldjango = {
                            function()
                                return {
                                    exe = "djlint",
                                    args = {
                                        "-",
                                        "--reformat",
                                    },
                                    stdin = true,
                                }
                            end,
                        },
                        markdown = {
                            prettier,
                            --function()
                            --    return {
                            --        exe = "markdownlint",
                            --        args = {
                            --            "-s",
                            --        },
                            --        stdin = true,
                            --    }
                            --end,
                        },
                    },
                }
            end,
        },
        -- {
        --     "mfussenegger/nvim-dap",
        --     config = function()
        --         local dap = require "dap"
        --         dap.adapters.codelldb = {
        --             type = "server",
        --             port = "${port}",
        --             executable = {
        --                 command = vim.fn.trim(vim.fn.system "which codelldb"),
        --                 args = { "--port", "${port}" },
        --             },
        --         }
        --         dap.adapters.cppdbg = {
        --             id = "cppdbg",
        --             type = "executable",
        --             command = vim.fn.trim(vim.fn.system "which OpenDebugAD7"),
        --         }

        --         local function ask_program()
        --             return vim.fn.input {
        --                 prompt = "Path to executable: ",
        --                 default = vim.fn.getcwd() .. "/",
        --                 completion = "file",
        --             }
        --         end

        --         local c_configs = {
        --             {
        --                 name = "Launch file (cppdbg)",
        --                 type = "cppdbg",
        --                 request = "launch",
        --                 program = ask_program,
        --                 cwd = "${workspaceFolder}",
        --                 stopAtEntry = false,
        --             },
        --             {
        --                 name = "Launch file (codelldb)",
        --                 type = "codelldb",
        --                 request = "launch",
        --                 program = ask_program,
        --                 cwd = "${workspaceFolder}",
        --                 stopAtEntry = false,
        --             },
        --         }
        --         dap.configurations.c = {
        --             table.unpack(c_configs),
        --         }
        --         dap.configurations.cpp = {
        --             table.unpack(c_configs),
        --         }
        --         dap.configurations.rust = {
        --             table.unpack(c_configs),
        --         }

        --         keymap.setup_dap {}
        --     end,
        -- },
        -- {
        --     "rcarriga/nvim-dap-ui",
        --     dependencies = { "mfussenegger/nvim-dap" },
        --     opts = {},
        --     config = function(_, opts)
        --         local dap = require "dap"
        --         local dapui = require "dapui"

        --         dapui.setup(opts)

        --         dap.listeners.after.event_initialized.dapui = dapui.open
        --         dap.listeners.before.event_terminated.dapui = dapui.close
        --         dap.listeners.before.event_exited.dapui = dapui.close
        --     end,
        -- },
        {
            "numToStr/Comment.nvim",
            opts = {},
        },
        {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                require("nvim-treesitter.install").update { with_sync = true }()
            end,
            config = function()
                require("nvim-treesitter.configs").setup {
                    auto_install = true,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                }
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                defaults = {
                    file_ignore_patterns = { "target", "node_modules", "%.git", "build" },
                },
            },
            config = function(_, opts)
                require("telescope").setup(opts)
                keymap.setup_telescope {}
            end,
        },
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            opts = {},
            config = function(_, opts)
                local toggleterm = require "toggleterm"
                toggleterm.setup(opts)

                keymap.setup_toggleterm {}
            end,
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {},
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            opts = {},
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            opts = {
                options = {
                    theme = "kanagawa",
                },
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory
                            path = 1,

                            -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            shorting_target = 40,
                            symbols = {
                                modified = "[+]", -- Text to show when the file is modified.
                                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                                newfile = "[New]", -- Text to show for newly created file before first write
                            },
                        },
                    },
                },
            },
        },
        {
            "akinsho/bufferline.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            event = "ColorScheme",
            opts = {},
            config = function(_, opts)
                require("bufferline").setup(opts)
            end,
        },
        {
            "folke/tokyonight.nvim",
            lazy = true,
            opts = {},
        },
        {
            "rebelot/kanagawa.nvim",
            lazy = true,
            opts = {},
        },
    }, {
        install = {
            colorscheme = { sets.colorscheme },
        },
    })
    sets.lazy_setup {}
end

return M
