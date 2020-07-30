call plug#begin('~/.config/nvim/plugged')

"Colours
Plug 'norcalli/nvim-colorizer.lua'
Plug 'christianchiarulli/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
source $HOME/.config/nvim/plug-config/coc.vim
Plug 'sheerun/vim-polyglot'
Plug 'metakirby5/codi.vim'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'

call plug#end()

"General Settings
set encoding=UTF-8
syntax on  "Turning Syntax on
set spell spelllang=en_us
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab  
set hls is ic
set laststatus=2 cmdheight=1
set splitbelow splitright 
set nobackup nowritebackup
set relativenumber



"Status-line
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]


"keybinds
" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <C-i> :e $MYVIMRC<CR>

" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"




"Colour scheme
hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

syntax on
colorscheme onedark


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

luafile $HOME/.config/nvim/lua/plug-colorizer.lua

source $HOME/.config/nvim/plug-config/gitgutter.vim
