set nocompatible             " do not include old vi compatibility"
set nu rnu                      " relative line numbers"
set clipboard=unnamedplus    " clipboard to work correctly on all platforms"
set t_Co=256   " colors in terminal"
set tabstop=4  " number of columns occupied by a tab "
set autoindent " indent a new line the same amount as the line just typed"
set noswapfile " self explanatory"
set encoding=UTF-8

" Enable folding
set foldmethod=indent
set foldlevel=99

" highlight currentline
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhinz/vim-startify'

Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

Plug 'preservim/nerdcommenter'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

" Install or update missing plugins if missing
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Airline settings

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NerdTree settings
let NERDTreeShowHidden=1

" remap opening nerdtree to F6
nmap <F6> :NERDTreeToggle<CR>  

" Use the already installed dracula theme
colorscheme dracula

let mapleader="\<Space>"

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
