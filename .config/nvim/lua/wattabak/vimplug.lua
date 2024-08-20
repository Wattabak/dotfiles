local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- The default plugin directory will be as follows:
--   - Vim (Linux/macOS): '~/.vim/plugged'
--   - Vim (Windows): '~/vimfiles/plugged'
--   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
-- You can specify a custom plugin directory by passing it as the argument
--   - e.g. `call plug#begin('~/.vim/plugged')`
--   - Avoid using standard Vim directory names like 'plugin'

 --Make sure you use single quotes
Plug('dracula/vim', { ['as'] = 'dracula' })

--File tree
Plug('preservim/nerdtree')
Plug('Xuyuanp/nerdtree-git-plugin')
Plug('ryanoasis/vim-devicons')

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
--better search terms in telescope 
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
-- LSP
Plug('neoclide/coc.nvim', {['branch'] = 'release'})

Plug('mhinz/vim-startify')

Plug('Konfekt/FastFold')
Plug('tmhedberg/SimpylFold')
-- Single hotkey for toggling comments, like <C-/> in pycharm/vscode
Plug('preservim/nerdcommenter')
-- In order for this to work correctly you need to have pynvim installed, this can be done via `pip3 install --user pynvim`
-- visual debugger
Plug('puremourning/vimspector')
--syntax highlight
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('Pocco81/auto-save.nvim')

-- Easy way to open terminals, including lazygit, etc
Plug('akinsho/toggleterm.nvim', {['tag'] = '*'})

vim.call('plug#end')
