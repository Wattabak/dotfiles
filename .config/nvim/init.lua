-- Basic settings
vim.opt.compatible = false       -- Do not include old vi compatibility
vim.opt.number = true            -- Line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.clipboard = "unnamedplus" -- Clipboard to work correctly on all platforms
vim.opt.termguicolors = true     -- Better color support (replaces t_Co=256)
vim.opt.tabstop = 4              -- Number of columns occupied by a tab
vim.opt.autoindent = true        -- Indent a new line the same amount as the line just typed
vim.opt.swapfile = false         -- No swap files
vim.opt.encoding = "UTF-8"       -- UTF-8 encoding
vim.opt.modifiable = true        -- Buffer is modifiable

-- Enable folding
vim.opt.foldmethod = "indent"    -- Fold based on indentation
vim.opt.foldlevel = 99           -- Start with all folds open

-- Highlight current line
vim.opt.cursorline = true
vim.api.nvim_command("hi cursorline cterm=none term=none")

-- Auto commands for cursor line
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end
})

vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end
})

-- Load custom module
require("wattabak")

-- Airline settings
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions_tabline_enabled = 1

