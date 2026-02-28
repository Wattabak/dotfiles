return {
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      keymaps = {
        view = {
          { "n", "<leader>gs", "<CMD>windo set scrollbind!<CR>", { desc = "Toggle diff scroll sync" } },
        },
      },
    },
  },
}
