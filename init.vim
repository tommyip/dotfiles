call plug#begin('~/.local/share/nvim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'chaoren/vim-wordmotion'
if !exists('g:vscode')
    Plug 'joshdick/onedark.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'jiangmiao/auto-pairs'
endif
call plug#end()

let mapleader = " "

" Use system clipboard
set clipboard+=unnamedplus

nnoremap ss 0
vnoremap ss 0
nnoremap ; $
vnoremap ; $
nnoremap k gk
nnoremap j gj

nnoremap <leader>h :noh<CR>

" Search current selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>N

" Easymotion
map <leader>w <Plug>(easymotion-bd-w)
map <leader>f <Plug>(easymotion-bd-f)
map <leader>l <Plug>(easymotion-bd-jk)

" Wordmotion
let g:wordmotion_spaces = '_-.'
" Use the default WORD definition
let g:wordmotion_mappings = {
    \ 'W': '',
    \ 'B': '',
    \ 'E': '',
    \ 'gE': '',
    \ 'aW': '',
    \ 'iW': ''
\ }

if !exists('g:vscode')
    set termguicolors
    colorscheme onedark

    set tabstop=4
    set shiftwidth=4
    set expandtab
    set relativenumber

    let g:lightline = { 'colorscheme': 'onedark' }

    inoremap jk <esc>
    tnoremap jk <C-\><C-n>

    nnoremap > <C-w>>
    nnoremap < <C-w><
    nnoremap = <C-w>+
    nnoremap 0 <C-w>-

    nnoremap <C-w>h <C-w><C-h>
    nnoremap <C-w>j <C-w><C-j>
    nnoremap <C-w>k <C-w><C-k>
    nnoremap <C-w>l <C-w><C-l>

    nnoremap <M-k> dd2kp
    nnoremap <M-j> ddp

    nnoremap <Tab> :bnext<cr>
    nnoremap <S-Tab> :bprevious<cr>

    tnoremap <Esc> <C-\><C-n>
endif
