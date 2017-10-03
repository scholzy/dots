" .vimrc
" Author: Michael Scholz
" Email: m@scholz.moe
"

" Install vim-plug if it's not already installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')

" General settings
" Alignment {{{
Plug 'tommcdo/vim-lion'
" }}}
" Backup handling {{{
set backup
set noswapfile

set undodir=~/.config/nvim/tmp/undo//     " undo files
set backupdir=~/.config/nvim/tmp/backup// " backups
set directory=~/.config/nvim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" Directional keybindings {{{
" Move by visual line, not textual line
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" }}}
" Folding {{{
set foldmethod=marker
" }}}
" Indenting {{{
" Allow indenting by block in visual mode
vnoremap < <gv
vnoremap > >gv|
" }}}
" Searching {{{
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
" }}}
" Spaces, not tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}
" Text objects {{{
Plug 'wellle/targets.vim'
" }}}

" Colors and UI
" Colorscheme {{{
colorscheme noctu
" }}}
" Statusline {{{
Plug 'itchyny/lightline.vim'
set laststatus=2 " Make sure the statusline is turned on
set noshowmode " No need to show --INSERT-- anymore
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
" }}}

" Filetype-specific
" LaTeX {{{
Plug 'lervag/vimtex', {'for': 'tex'}
au FileType tex set linebreak
" }}}
" Rust {{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" }}}

call plug#end()
