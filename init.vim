" Author: Tommy Ip
" Platform: Neovim/Linux (Mint 18)

set nocompatible
set fdm=marker
set background=dark
set termguicolors
colorscheme spacemacs-theme

" Vim-Plug {{{
set rtp+=~/.config/nvim/autoload/plug.vim
let g:plug_threads = 16

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'carlitux/deoplete-ternjs'
Plug 'rust-lang/rust.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'posva/vim-vue'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/indentpython.vim'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'yggdroot/indentline'
Plug 'easymotion/vim-easymotion'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'Shougo/unite.vim'
Plug 'Valloric/ListToggle'
Plug 'honza/vim-snippets'
Plug 'alvan/vim-closetag'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'yuttie/comfortable-motion.vim'

call plug#end()
" }}}

" Vim settings {{{
filetype plugin indent on
filetype on
syntax on
let mapleader="\<space>"
set shell=zsh
set updatetime=250
set numberwidth=4
set tabstop=4
set shiftwidth=4
set expandtab
set modelines=0
set number
set relativenumber
set ruler
set visualbell
set wrap
set linebreak
set nolist
set textwidth=79
set formatoptions=tcqrn1
set noshiftround
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>
set hidden
set laststatus=2
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set wildmenu
set noerrorbells
set listchars=tab:▸\ ,eol:¬
set omnifunc=syntaxcomplete#Complete
set mouse=a
set splitbelow
set splitright
set linespace=0
set clipboard+=unnamedplus
set noswapfile
set undodir=~/.undodir/
set undofile
set foldlevel=99
set equalalways
set colorcolumn=79

runtime! macros/matchit.vim
" }}}
" Neovim settings {{{
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" }}}
" Auto groups {{{
augroup SyncSyntaxHighlight
    autocmd!
    autocmd BufEnter * :syntax sync minlines=200
augroup END

augroup RunNeomake
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

augroup ForthLang
    autocmd!
    autocmd BufNewFile,BufRead *.fs setlocal ft=gforth
    autocmd FileType gforth setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup ReloadVimrc
    autocmd!
    autocmd BufWritePost init.vim source $MYVIMRC
augroup END

augroup CursorLine
    autocmd!
    autocmd VimEnter, WinEnter, BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" }}}

" Plugin - Unite {{{
let g:unite_source_menu_menus = get(g: ,'unite_source_menu_menus', {})
let g:unite_source_menu_menus.git = {'description' : 'Git commands'}
let g:unite_source_menu_menus.git.command_candidates = [
    \[' git status',   'Gstatus'],
    \[' git stage',    'Gwrite'],
    \[' git commit',   'Gcommit'],
    \[' git diff',     'Gdiff'],
    \[' git log',      'exe "silent Glog | Unite quickfix"'],
    \[' git push',     'Git! push'],
    \[' git pull',     'Git! pull'],
    \[' git blame',    'Gblame'],
    \[' git checkout', 'Gread'],
    \[' git rm',       'Gremove'],
    \[' git mv',       'exe "Gmove " input("destino: ")'],
    \[' git prompt',   'exe "Git! " input("comando git: ")'],
    \[' git cd',       'Gcd'],
\]
let g:unite_source_menu_menus.config = {'description' : "Configuration menu"}
let g:unite_source_menu_menus.config.command_candidates = [
    \[' init.vim', 'e ~/dotfiles/init.vim'],
    \[' .zshrc',   'e ~/.zshrc'],
\]
nnoremap <silent><leader>1 :Unite -silent -quick-match -winheight=14 menu:git<cr>
nnoremap <silent><leader>2 :Unite -silent -quick-match -winheight=3 menu:config<cr>
" }}}
" Plugin - NERDTree settings {{{
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_startup_cd = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrowExpandable=""
let g:NERDTreeDirArrowCollapsible=""
" }}}
" Plugin - Airline settings {{{
let g:airline_theme = 'base16_spacemacs'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#wordcount#enabled = 0
let g:airline_section_b = airline#section#create(['branch'])
let g:airline_section_z = airline#section#create(['%{strftime("%H:%M %d/%m")}'])

let g:airline#extensions#default#section_truncate_width = {
    \ 'a': 50,
    \ 'b': 50,
    \ 'c': 50,
    \ 'x': 70,
    \ 'z': 120
\ }
let g:airline#extensions#default#layout = [
    \ ['a', 'b', 'c'],
    \ ['x', 'z', 'error', 'warning']
\]

" }}}
" Plugin - Indent Line {{{
let g:indentLine_color_gui = '#373040'
" }}}
" Plugin - Neomake {{{
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_elixir_enabled_makers = ['elixirc']
let g:neomake_rust_enabled_makers = ['rustc']
let g:neomake_open_list = 0
" }}}
" Plugin - Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 20
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 20
let g:deoplete#omni_patterns = {}

let g:deoplete#sources#rust#racer_binary='/home/tommy/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/tommy/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

let g:tern#filetypes = ['vue']
let g:tern_show_signature_in_pum = '0'
" }}}
" Plugin - ToggleList {{{
let g:toggle_list_no_mappings = 1
" }}}
" Plugin - Super Tab {{{
let g:SuperTabDefaultCompletionType = "<C-n>"
" }}}
" Plugin - Devicons {{{
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
" }}}
" Plugin - Easymotion {{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
" }}}
" Plugin - GitGutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_lines = 1
" }}}
" Plugin - ListToggle {{{
let g:lt_location_list_toggle_map = '<leader>g'
let g:lt_quickfix_list_toggle_map = '<leader>h'
" }}}
" Plugin - Comfortable-motion {{{
let g:comfortable_motion_no_default_key_mappings = 1
" }}}

" Functions {{{
" Cursors {{{
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete=1
endfunction
function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete=0
endfunction
" }}}
" Fzf {{{
function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}
" Clear Registers {{{
function! ClearRegisters()
    let regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i = 0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction
command! ClearRegisters call ClearRegisters()
" }}}
" }}}

" Key bindings {{{

inoremap jk <esc>
tnoremap jk <C-\><C-n>

" Do you even Vim?
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" New plane
nnoremap <leader>sl <C-w>v
nnoremap <leader>sj <C-w>s

" Rotate plane
nnoremap <leader>sr <C-W>R

" Change plane size
nnoremap > <C-w>>
nnoremap < <C-w><
nnoremap = <C-w>+
nnoremap - <C-w>-

" Delete buffer
nnoremap <leader>q :bd<cr>

" Close plane
nnoremap Q <c-w>q

" Exit Vim
nnoremap <leader>Q :xa<cr>

" Save file
nnoremap fs :w<cr>

" Open folds
nnoremap <leader>o za
" Close all folds
nnoremap <leader>p zM
" Open all folds
nnoremap <leader>i zR

" Copy & Paste to/from clipboard
vnoremap Y "+y
nnoremap P "+p

" Move around planes
nnoremap <leader>H <C-w>h
nnoremap <leader>L <C-w>l
nnoremap <leader>J <C-w>j
nnoremap <leader>K <C-w>k

" Move between virtual lines
nnoremap j gj
nnoremap k gk

nnoremap ss 0
vnoremap ss 0
nnoremap ; $
vnoremap ; $

" Move lines
nnoremap K dd2kp
nnoremap J ddp

nnoremap <silent><leader>e :enew<cr>

" Clear search highlighting
nnoremap <silent> cl :silent! let @/=''<cr>

" Switch between absolute and relative line number
nnoremap <silent><M-r> :set relativenumber!<cr>

" Tabs
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

nnoremap <silent><M-g> :GitGutterToggle<cr>
nnoremap <silent><M-n> :NERDTreeToggle<cr>
nnoremap <silent><M-u> :UndotreeToggle<cr>
nnoremap <silent><M-t> :TagbarToggle<cr>

" Easy motion
nmap m <Plug>(easymotion-bd-w)
nmap fl <Plug>(easymotion-bd-wl)
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Unite
nnoremap <leader>b :Unite -quick-match buffer<cr>

nnoremap + :Gwrite<cr>

nnoremap <silent> <M-j> :call comfortable_motion#flick(80)<CR>
nnoremap <silent> <M-k> :call comfortable_motion#flick(-80)<CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" }}}
