return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    require("oil").setup(opts)
    function _G.OilBreadcrumb()
      local ok, oil = pcall(require, "oil")
      if not ok then return "" end
      local dir = oil.get_current_dir()
      if not dir then return "" end
      local root = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
      local rel
      if dir:sub(1, #root) == root then
        local stripped = dir:sub(#root + 2):gsub("/$", "")
        local rootname = vim.fn.fnamemodify(root, ":t")
        rel = stripped == "" and rootname or rootname .. "/" .. stripped
      else
        rel = vim.fn.fnamemodify(dir, ":~"):gsub("/$", "")
      end
      return "%#Comment#" .. rel:gsub("/", " › ") .. "%*"
    end
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function(args)
        vim.opt_local.winbar = "%{%v:lua.OilBreadcrumb()%}"
        vim.keymap.set("n", "<C-p>", function()
          require("oil.actions").preview.callback()
        end, { buffer = args.buf, desc = "Toggle preview" })
      end,
    })
  end,
  opts = {
    -- Your oil.nvim configuration options
    restore_win_options = true,
    constrain_cursor = "name",
    view_options = {
      show_hidden = true,
    },
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		  columns = {
    "icon",
    -- "permissions",
    "size",
    "mtime",
  },
  keymaps = {
		  ["<C-p>"] = {"actions.preview", opts = {split = "botright"}},
  },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- Sort file names with numbers in a more intuitive order for humans.
    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
    natural_order = "fast",
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  },
}
