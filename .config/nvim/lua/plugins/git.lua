return {
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_win_enter = function()
          vim.opt_local.winhl = table.concat({
            "DiffAdd:DiffviewDiffAdd",
            "DiffDelete:DiffviewDiffDelete",
            "DiffChange:DiffviewDiffChange",
            "DiffText:DiffviewDiffText",
          }, ",")
        end,
      },
      keymaps = {
        view = {
          { "n", "<leader>gs", "<CMD>windo set scrollbind!<CR>", { desc = "Toggle diff scroll sync" } },
        },
      },
    },
  },
}
