" ==========================
" 🌙 NEOVIM CONFIG (Dark + OneDark)
" ==========================

" ========== PLUGIN MANAGEMENT ==========
call plug#begin('~/.config/nvim/plugged')

" Theme (VS Code-style dark)
Plug 'joshdick/onedark.vim'

" Autocompletion (CoC)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Explorer + Icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

" ========== GENERAL SETTINGS ==========
set number                      " Show line numbers
set relativenumber              " Relative line numbers
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
set expandtab                   " Convert tabs to spaces
set autoindent                  " Maintain indent from current line
set smartindent                 " Smart indentation
set background=dark             " Dark background
set termguicolors               " Enable true color support
set clipboard=unnamedplus       " Use system clipboard
set hidden                      " Allow background buffers
set signcolumn=yes              " Always show sign column
syntax on

" Enable persistent undo
set undofile
set undodir=~/.config/nvim/undo

" ========== COLORSCHEME ==========
colorscheme onedark

" Remove transparency (solid dark background)
hi Normal guibg=#1e222a ctermbg=NONE
hi NormalNC guibg=#1e222a ctermbg=NONE

" ========== LUA CONFIG ==========
lua << EOF
require('lualine').setup {
  options = {
    theme = 'onedark',
    section_separators = '',
    component_separators = ''
  }
}

require('nvim-tree').setup {}
EOF

" ========== KEYBINDINGS ==========
let mapleader = ","

" Toggle file explorer
nnoremap <C-n> :NvimTreeToggle<CR>

" Yank to system clipboard
vnoremap <leader>y "+y

" ========== COC AUTOCOMPLETE MAPPINGS ==========
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <CR>  pumvisible() ? coc#_select_confirm() : "\<CR>"

" Close popup menu on Space
inoremap <expr> <Space> pumvisible() ? "\<C-e>\<Space>" : "\<Space>"

" Close popup menu on arrow keys
inoremap <expr> <Up>    pumvisible() ? "\<C-e>\<Up>"    : "\<Up>"
inoremap <expr> <Down>  pumvisible() ? "\<C-e>\<Down>"  : "\<Down>"
inoremap <expr> <Left>  pumvisible() ? "\<C-e>\<Left>"  : "\<Left>"
inoremap <expr> <Right> pumvisible() ? "\<C-e>\<Right>" : "\<Right>"


" ========== AUTO FORMAT ON SAVE ==========
autocmd BufWritePre *.py,*.c,*.cpp,*.js,*.ts,*.html,*.css,*.json,*.sh :silent! call CocAction('format')
