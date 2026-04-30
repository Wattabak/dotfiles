return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signcolumn = true,
      numhl = false,
      current_line_blame = false,
      preview_config = { border = "rounded" },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.nav_hunk("next") end)
          return "<Ignore>"
        end, "Next hunk")
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.nav_hunk("prev") end)
          return "<Ignore>"
        end, "Prev hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff vs index")
        map("n", "<leader>hD", function() gs.diffthis("main") end, "Diff vs main")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>htd", gs.toggle_deleted, "Toggle deleted")
        map("n", "<leader>hcb", function()
          vim.ui.input({ prompt = "Diff base (branch/ref): ", default = "main" }, function(ref)
            if ref and ref ~= "" then gs.change_base(ref, true) end
          end)
        end, "Change diff base")
      end,
    },
  },
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
          { "n", "dO", "<CMD>%diffget | write<CR>", { desc = "Obtain all diff hunks from other side" } },
        },
      },
    },
  },
}
