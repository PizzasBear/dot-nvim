---@module "lazy"
---@type LazyPluginSpec
return {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {
        -- Number of lines within which surrounding is searched
        n_lines = 300,
    },
}
