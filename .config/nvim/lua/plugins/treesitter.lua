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

return {
  M,
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 4,
      multiline_threshold = 1,
      trim_scope = "outer",
    },
    keys = {
      { "<leader>tc", "<CMD>TSContextToggle<CR>", desc = "Toggle ts-context" },
      {
        "[x",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "Jump to context (parent)",
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick breadcrumb" },
    },
    opts = {
      bar = {
        padding = { left = 1, right = 1 },
        pick = { pivots = "asdfghjkl;" },
      },
      icons = {
        ui = {
          bar = { separator = "  ", extends = "…" },
          menu = { separator = " ", indicator = "  " },
        },
        kinds = {
          use_devicons = true,
        },
      },
      menu = {
        win_configs = {
          border = "rounded",
          style = "minimal",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
          local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
          local bg = norm.bg
          vim.api.nvim_set_hl(0, "WinBar",        { bg = bg, fg = comment.fg })
          vim.api.nvim_set_hl(0, "WinBarNC",      { bg = bg, fg = comment.fg })
          vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { bg = bg, fg = "#44475a" })
          vim.api.nvim_set_hl(0, "DropBarIconUIPickPivot", { bg = bg, fg = "#ff79c6", bold = true })
          for _, grp in ipairs({
            "DropBarIconKindFolder", "DropBarKindFolder",
            "DropBarIconKindFile",   "DropBarKindFile",
          }) do
            vim.api.nvim_set_hl(0, grp, { bg = bg, fg = comment.fg })
          end
          vim.api.nvim_set_hl(0, "DropBarCurrentContext", { bg = bg, fg = "#f8f8f2", bold = true })
        end,
      })
      vim.cmd.doautocmd("ColorScheme")
    end,
  },
}
