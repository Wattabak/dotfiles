-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  spec = {
    -- Color scheme
    {
      "dracula/vim",
      name = "dracula",
      priority = 1000,
      lazy = false,
      config = function()
        vim.cmd.colorscheme("dracula")
      end,
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },

    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
      },
    },

    -- Status line
    {
      "nvim-lualine/lualine.nvim", -- Replacement for vim-airline
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {},
    },

    -- Start screen
    {
      "mhinz/vim-startify",
    },

    -- Comments
    {
      "numToStr/Comment.nvim", -- Modern replacement for nerdcommenter
      opts = {
        -- Add other options here if needed
        toggler = {
          -- Line comment keymap
          line = "<Leader>cc",
          -- Block comment keymap
          block = "gbc",
        },
      },
    },

    -- Autosave
    -- {
    -- 	"okuuva/auto-save.nvim", -- Fork of Pocco81/auto-save.nvim which is archived
    -- 	opts = {},
    -- },

    -- Debugger (vimspector replacement)
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "rcarriga/nvim-dap-ui",
      },
    },
    -- LSP Configuration

    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    },

    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
      end
    },
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "dracula" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
