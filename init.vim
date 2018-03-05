" init.vim
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
" Things that need to be done first
" Leader key {{{
let mapleader = " "
nnoremap <SPACE> <Nop>
let maplocalleader = ","
" }}}

" General settings
" Alignment {{{
Plug 'tommcdo/vim-lion'
" }}}
" Backup handling {{{
set backup
set swapfile
set undofile

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
" Completion {{{
Plug 'lifepillar/vim-mucomplete'
set completeopt+=menuone
" }}}
" Directional keybindings {{{
" Move by visual line, not textual line
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" }}}
" Directory navigation {{{
Plug 'justinmk/vim-dirvish'
" }}}
" Folding {{{
set foldmethod=marker
" Automagically navigate and open/close folds while moving
nnoremap <silent> z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap <silent> z[ :<C-u>silent! normal! zc<CR>zkzo[zzz
" }}}
" Fuzzy finding {{{
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all --no-update-rc'}
Plug 'junegunn/fzf.vim'
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :Files<CR>
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_override_sign_column_highlight = 0
" }}}
" Indenting {{{
" Allow indenting by block in visual mode
vnoremap < <gv
vnoremap > >gv|
" }}}
" Line length {{{
nnoremap <silent> <leader>c :let &cc = &cc == '' ? '80' : ''<CR>
" }}}
" Linting {{{
Plug 'w0rp/ale'
let g:ale_sign_error = "x "
let g:ale_sign_warning = "- "
" }}}
" Minimal view {{{
Plug 'junegunn/goyo.vim'
" }}}
" Pairwise movement {{{
Plug 'tpope/vim-unimpaired'
" }}}
" Searching {{{
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

nnoremap <leader>n :noh<CR>

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
" Startup page {{{
Plug 'mhinz/vim-startify'
" }}}
" Tables {{{
Plug 'dhruvasagar/vim-table-mode'
" }}}
" Text objects {{{
Plug 'wellle/targets.vim'
" }}}

" Colors and UI
" Colorscheme {{{
" colorscheme noctu
" Plug 'morhetz/gruvbox'
let g:coralbox_termcolors = 16
let g:coralbox_contrast_dark = 'medium'
let g:coralbox_italic = 1
let g:coralbox_italicize_comments = 0
set background=dark
colo coralbox
" }}}
" Statusline {{{
Plug 'itchyny/lightline.vim'
set laststatus=2 " Make sure the statusline is turned on
set noshowmode " No need to show --INSERT-- anymore
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
"     \ 'component_function': {
"     \   'readonly': 'LightlineReadonly',
"     \   'fugitive': 'LightlineFugitive'
"     \ }
"     " \ 'separator': { 'left': '', 'right': '' },
"     " \ 'subseparator': { 'left': '', 'right': '' }
"     \ }
" function! LightlineReadonly()
"     return &readonly ? '' : ''
" endfunction
" function! LightlineFugitive()
"     if exists('*fugitive#head')
"         let branch = fugitive#head()
"         return branch !=# '' ? ''.branch : ''
"     endif
"     return ''
" endfunction
" }}}

" Filetype-specific
" C {{{
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'c'}
" }}}
" C++ {{{
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
" }}}
" Clojure {{{
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
" }}}
" Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
" }}}
" Haskell {{{
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
" }}}
" Javascript {{{
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" }}}
" Julia {{{
Plug 'JuliaEditorSupport/julia-vim'
" }}}
" LaTeX {{{
Plug 'lervag/vimtex', {'for': 'tex'}
au FileType tex set linebreak
let g:tex_conceal = ""
" }}}
" Markdown {{{
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" }}}
" Molpro {{{
Plug 'antoniogsof/vim-molpro', {'for': 'molpro'}
" }}}
" Nim {{{
Plug 'zah/nim.vim', {'for': 'nim'}
" }}}
" org-mode {{{
Plug 'jceb/vim-orgmode', {'for': 'org'}
" }}}
" Python {{{
" Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
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
" R {{{
Plug 'jalvesaq/Nvim-R', {'for': 'r'}
" }}}
" Rust {{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'racer-rust/vim-racer', {'for': 'rust'}
" }}}

call plug#end()
