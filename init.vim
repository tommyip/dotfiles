call plug#begin('~/.local/share/nvim/plugged')
Plug 'easymotion/vim-easymotion'
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

    nnoremap <M-h> <C-w><C-h>
    nnoremap <M-j> <C-w><C-j>
    nnoremap <M-k> <C-w><C-k>
    nnoremap <M-l> <C-w><C-l>

    nnoremap K dd2kp
    nnoremap J ddp

    nnoremap <Tab> :bnext<cr>
    nnoremap <S-Tab> :bprevious<cr>

    tnoremap <Esc> <C-\><C-n>
endif
