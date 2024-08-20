set nocompatible             " do not include old vi compatibility"
set nu rnu                      " relative line numbers"
set clipboard=unnamedplus    " clipboard to work correctly on all platforms"
set t_Co=256   " colors in terminal"
set tabstop=4  " number of columns occupied by a tab "
set autoindent " indent a new line the same amount as the line just typed"
set noswapfile " self explanatory"
set encoding=UTF-8
set modifiable
" Enable folding
set foldmethod=indent
set foldlevel=99

" highlight currentline
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

:lua require("wattabak")

" Airline settings

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NerdTree settings
let NERDTreeShowHidden=1

" remap opening nerdtree to F6
nmap <F6> :NERDTreeToggle<CR>
" Use the already installed dracula theme
colorscheme dracula

