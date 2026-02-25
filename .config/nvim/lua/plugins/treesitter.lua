local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts = {
        ensure_installed = {
            "python",
            "typescript",
            "javascript",
            "tsx",
            "markdown",
            "markdown_inline",
            "terraform",
            "hcl",
            "bash",
            "lua",
            "json",
            "yaml",
            "html",
            "css",
        },
        highlight = { enable = true },
    },
}

return { M }
