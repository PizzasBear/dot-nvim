-- Plugin is disabled
do return end

local keymap = require "keymap"

assert(vim.version.range(">=0.10"):has(vim.version()))

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        ---@type vim.event.packchanged.data
        local data = ev.data
        if data.spec.name == "telescope-fzf-native.nvim" and (data.kind == "install" or data.kind == "update") then
            local proc = vim.system({
                "sh",
                "-c",
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
            }, { cwd = data.path }):wait()
            assert(proc.code == 0, "Failed to compile telescope-fzf-native")
        end
    end,
})

vim.pack.add {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
}
require("telescope").setup {}
require("telescope").load_extension "fzf"

keymap.apply(keymap.telescope)
