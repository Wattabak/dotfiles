return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Your oil.nvim configuration options
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
