---@type LazyPluginSpec
return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    enabled = false,

    opts = function()
        local null_ls = require "null-ls"
        local utils = require "null-ls.utils"
        local helpers = require "null-ls.helpers"

        return {
            -- on_init = function(client, _)
            --     client.offset_encoding = "utf-8"
            -- end,
            sources = {
                null_ls.builtins.formatting.stylua,
                {
                    name = "ruff",
                    meta = {
                        url = "https://github.com/astral-sh/ruff",
                        description = "An extremely fast Python linter and code formatter, written in Rust.",
                    },
                    method = { null_ls.methods.FORMATTING, null_ls.methods.RANGE_FORMATTING },
                    filetypes = { "python" },
                    generator = helpers.formatter_factory {
                        command = "ruff",
                        args = function(params)
                            if params.method == null_ls.methods.RANGE_FORMATTING then
                                return {
                                    "format",
                                    "--quiet",
                                    "--range=" .. params.range.row .. "-" .. params.range.end_row,
                                    "--stdin-filename",
                                    "$FILENAME",
                                }
                            end

                            return {
                                "format",
                                "--quiet",
                                "--stdin-filename",
                                "$FILENAME",
                            }
                        end,
                        to_stdin = true,
                        cwd = helpers.cache.by_bufnr(function(params)
                            return (utils.root_pattern "pyproject.toml")(params.bufname)
                        end),
                    },
                },
                -- null_ls.builtins.formatting.black,
                -- null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.prettier.with {
                    extra_filetypes = { "xml" },
                },
                null_ls.builtins.formatting.clang_format,
                -- {
                --     name = "templrfmt",
                --     filetypes = { "rust" },
                --     method = null_ls.methods.FORMATTING,
                --     generator = helpers.formatter_factory {
                --         command = "templrfmt",
                --         args = { "--stdin" },
                --         to_stdin = true,
                --     },
                -- },
            },
        }
    end,
}
