return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "dracula",
        globalstatus = true,
        section_separators = "",
        component_separators = "│",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
            source = function()
              local gs = vim.b.gitsigns_status_dict
              if gs then
                return { added = gs.added, modified = gs.changed, removed = gs.removed }
              end
            end,
          },
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = " [new]",
            },
          },
        },
        lualine_x = {
          {
            function()
              local file = vim.fn.expand("%:p")
              if file == "" or vim.bo.buftype ~= "" then return "" end
              local out = vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.fnamemodify(file, ":h")) ..
                " status --porcelain=v1 -- " .. vim.fn.shellescape(file) .. " 2>/dev/null")
              if vim.v.shell_error ~= 0 or #out == 0 then return "✓ committed" end
              local code = out[1]:sub(1, 2)
              if code:match("^%?%?") then return " untracked" end
              if code:sub(1, 1) ~= " " and code:sub(2, 2) ~= " " then return " staged+dirty" end
              if code:sub(1, 1) ~= " " then return " staged" end
              return " modified"
            end,
            color = { gui = "italic" },
          },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "oil", "lazy", "mason" },
    },
  },
}
