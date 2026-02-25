return {
  {
    "sindrets/diffview.nvim",
    opts = {
      keymaps = {
        view = {
          { "n", "<leader>gs", "<CMD>windo set scrollbind!<CR>", { desc = "Toggle diff scroll sync" } },
        },
      },
    },
  },
}
