" .vimrc
" Author: Michael Scholz
" Email: m@scholz.moe
"

" vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" }}}
call plug#begin('~/.config/nvim/plugged')
" Leader key {{{
let mapleader = " "
nnoremap <SPACE> <Nop>
let maplocalleader = ","
" }}}
"
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
" Commenting {{{
Plug 'tpope/vim-commentary'
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
" Fuzzy finding {{{
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :Files<CR>
" }}}
" Indenting {{{
" Allow indenting by block in visual mode
vnoremap < <gv
vnoremap > >gv|
" }}}
" Pairwise movement {{{
Plug 'tpope/vim-unimpaired'
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
" Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
" }}}
" LaTeX {{{
Plug 'lervag/vimtex', {'for': 'tex'}
au FileType tex set linebreak
" }}}
" Nim {{{
Plug 'zah/nim.vim', {'for': 'nim'}
" }}}
" Python {{{
Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
" Use python3 by default
let g:pymode_python = 'python3'
" Turn off the default options set up by python-mode
let g:pymode_options = 0
" Turn off linting on write
let g:pymode_lint_on_write = 0
" Use my config
autocmd FileType python call SetPythonOptions()
function! SetPythonOptions()
    setlocal linebreak
    setlocal textwidth=79
    setlocal commentstring=#%s
    setlocal define=^\s*\\(def\\\\|class\\)
endfunction
" }}}
" Rust {{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" }}}

call plug#end()
