local M = {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
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
            "elixir",
            "heex",
            "go",
        },
        highlight = { enable = true },
    },
}

return { M }
