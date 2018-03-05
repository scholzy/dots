" -----------------------------------------------------------------------------
" File: coralbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/coralbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='coralbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:coralbox_bold')
  let g:coralbox_bold=1
endif
if !exists('g:coralbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:coralbox_italic=1
  else
    let g:coralbox_italic=0
  endif
endif
if !exists('g:coralbox_undercurl')
  let g:coralbox_undercurl=1
endif
if !exists('g:coralbox_underline')
  let g:coralbox_underline=1
endif
if !exists('g:coralbox_inverse')
  let g:coralbox_inverse=1
endif

if !exists('g:coralbox_guisp_fallback') || index(['fg', 'bg'], g:coralbox_guisp_fallback) == -1
  let g:coralbox_guisp_fallback='NONE'
endif

if !exists('g:coralbox_improved_strings')
  let g:coralbox_improved_strings=0
endif

if !exists('g:coralbox_improved_warnings')
  let g:coralbox_improved_warnings=0
endif

if !exists('g:coralbox_termcolors')
  let g:coralbox_termcolors=256
endif

if !exists('g:coralbox_invert_indent_guides')
  let g:coralbox_invert_indent_guides=0
endif

if exists('g:coralbox_contrast')
  echo 'g:coralbox_contrast is deprecated; use g:coralbox_contrast_light and g:coralbox_contrast_dark instead'
endif

if !exists('g:coralbox_contrast_dark')
  let g:coralbox_contrast_dark='medium'
endif

if !exists('g:coralbox_contrast_light')
  let g:coralbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:cb = {}

" fill it with absolute colors
let s:cb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:cb.dark0       = ['#282828', 235]     " 40-40-40
let s:cb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:cb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:cb.dark2       = ['#504945', 239]     " 80-73-69
let s:cb.dark3       = ['#665c54', 241]     " 102-92-84
let s:cb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:cb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:cb.gray_245    = ['#928374', 245]     " 146-131-116
let s:cb.gray_244    = ['#928374', 244]     " 146-131-116

let s:cb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:cb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:cb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:cb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:cb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:cb.light3      = ['#bdae93', 248]     " 189-174-147
let s:cb.light4      = ['#a89984', 246]     " 168-153-132
let s:cb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:cb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:cb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:cb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:cb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:cb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:cb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:cb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:cb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:cb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:cb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:cb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:cb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:cb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:cb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:cb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:cb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:cb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:cb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:cb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:cb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:cb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:coralbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:coralbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:coralbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:coralbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:coralbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:cb.dark0
  if g:coralbox_contrast_dark == 'soft'
    let s:bg0  = s:cb.dark0_soft
  elseif g:coralbox_contrast_dark == 'hard'
    let s:bg0  = s:cb.dark0_hard
  endif

  let s:bg1  = s:cb.dark1
  let s:bg2  = s:cb.dark2
  let s:bg3  = s:cb.dark3
  let s:bg4  = s:cb.dark4

  let s:gray = s:cb.gray_245

  let s:fg0 = s:cb.light0
  let s:fg1 = s:cb.light1
  let s:fg2 = s:cb.light2
  let s:fg3 = s:cb.light3
  let s:fg4 = s:cb.light4

  let s:fg4_256 = s:cb.light4_256

  let s:red    = s:cb.bright_red
  let s:green  = s:cb.bright_green
  let s:yellow = s:cb.bright_yellow
  let s:blue   = s:cb.bright_blue
  let s:purple = s:cb.bright_purple
  let s:aqua   = s:cb.bright_aqua
  let s:orange = s:cb.bright_orange
else
  let s:bg0  = s:cb.light0
  if g:coralbox_contrast_light == 'soft'
    let s:bg0  = s:cb.light0_soft
  elseif g:coralbox_contrast_light == 'hard'
    let s:bg0  = s:cb.light0_hard
  endif

  let s:bg1  = s:cb.light1
  let s:bg2  = s:cb.light2
  let s:bg3  = s:cb.light3
  let s:bg4  = s:cb.light4

  let s:gray = s:cb.gray_244

  let s:fg0 = s:cb.dark0
  let s:fg1 = s:cb.dark1
  let s:fg2 = s:cb.dark2
  let s:fg3 = s:cb.dark3
  let s:fg4 = s:cb.dark4

  let s:fg4_256 = s:cb.dark4_256

  let s:red    = s:cb.faded_red
  let s:green  = s:cb.faded_green
  let s:yellow = s:cb.faded_yellow
  let s:blue   = s:cb.faded_blue
  let s:purple = s:cb.faded_purple
  let s:aqua   = s:cb.faded_aqua
  let s:orange = s:cb.faded_orange
endif

" reset to 16 colors fallback
if g:coralbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg1[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg4[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:cb.bg0 = s:bg0
let s:cb.bg1 = s:bg1
let s:cb.bg2 = s:bg2
let s:cb.bg3 = s:bg3
let s:cb.bg4 = s:bg4

let s:cb.gray = s:gray

let s:cb.fg0 = s:fg0
let s:cb.fg1 = s:fg1
let s:cb.fg2 = s:fg2
let s:cb.fg3 = s:fg3
let s:cb.fg4 = s:fg4

let s:cb.fg4_256 = s:fg4_256

let s:cb.red    = s:red
let s:cb.green  = s:green
let s:cb.yellow = s:yellow
let s:cb.blue   = s:blue
let s:cb.purple = s:purple
let s:cb.aqua   = s:aqua
let s:cb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:cb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:cb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:cb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:cb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:cb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:cb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg1[0]
  let g:terminal_color_15 = s:fg4[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:coralbox_hls_cursor')
  let s:hls_cursor = get(s:cb, g:coralbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:coralbox_number_column')
  let s:number_column = get(s:cb, g:coralbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:coralbox_sign_column')
    let s:sign_column = get(s:cb, g:coralbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:coralbox_color_column')
  let s:color_column = get(s:cb, g:coralbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:coralbox_vert_split')
  let s:vert_split = get(s:cb, g:coralbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:coralbox_invert_signs')
  if g:coralbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:coralbox_invert_selection')
  if g:coralbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:coralbox_invert_tabline')
  if g:coralbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:coralbox_italicize_comments')
  if g:coralbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:coralbox_italicize_strings')
  if g:coralbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:coralbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:coralbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Coralbox Hi Groups: {{{

" memoize common hi groups
call s:HL('CoralboxFg0', s:fg0)
call s:HL('CoralboxFg1', s:fg1)
call s:HL('CoralboxFg2', s:fg2)
call s:HL('CoralboxFg3', s:fg3)
call s:HL('CoralboxFg4', s:fg4)
call s:HL('CoralboxGray', s:gray)
call s:HL('CoralboxBg0', s:bg0)
call s:HL('CoralboxBg1', s:bg1)
call s:HL('CoralboxBg2', s:bg2)
call s:HL('CoralboxBg3', s:bg3)
call s:HL('CoralboxBg4', s:bg4)

call s:HL('CoralboxRed', s:red)
call s:HL('CoralboxRedBold', s:red, s:none, s:bold)
call s:HL('CoralboxGreen', s:green)
call s:HL('CoralboxGreenBold', s:green, s:none, s:bold)
call s:HL('CoralboxYellow', s:yellow)
call s:HL('CoralboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('CoralboxBlue', s:blue)
call s:HL('CoralboxBlueBold', s:blue, s:none, s:bold)
call s:HL('CoralboxPurple', s:purple)
call s:HL('CoralboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('CoralboxAqua', s:aqua)
call s:HL('CoralboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('CoralboxOrange', s:orange)
call s:HL('CoralboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('CoralboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('CoralboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('CoralboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('CoralboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('CoralboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('CoralboxAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/coralbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText CoralboxBg2
hi! link SpecialKey CoralboxBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory CoralboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title CoralboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg CoralboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg CoralboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question CoralboxOrangeBold
" Warning messages
hi! link WarningMsg CoralboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:blue, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:coralbox_improved_strings == 0
  hi! link Special CoralboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement CoralboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional CoralboxRed
" for, do, while, etc.
hi! link Repeat CoralboxRed
" case, default, etc.
hi! link Label CoralboxRed
" try, catch, throw
hi! link Exception CoralboxRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword CoralboxRed

" Variable name
hi! link Identifier CoralboxBlue
" Function name
hi! link Function CoralboxGreenBold

" Generic preprocessor
hi! link PreProc CoralboxAqua
" Preprocessor #include
hi! link Include CoralboxAqua
" Preprocessor #define
hi! link Define CoralboxAqua
" Same as Define
hi! link Macro CoralboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit CoralboxAqua

" Generic constant
hi! link Constant CoralboxPurple
" Character constant: 'c', '/n'
hi! link Character CoralboxPurple
" String constant: "this is a string"
if g:coralbox_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean CoralboxPurple
" Number constant: 234, 0xff
hi! link Number CoralboxPurple
" Floating point constant: 2.3e10
hi! link Float CoralboxPurple

" Generic type
hi! link Type CoralboxYellow
" static, register, volatile, etc
hi! link StorageClass CoralboxOrange
" struct, union, enum, etc.
hi! link Structure CoralboxRed
" typedef
hi! link Typedef CoralboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:coralbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

autocmd ColorScheme coralbox hi! link Sneak Search
autocmd ColorScheme coralbox hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:coralbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd CoralboxGreenSign
hi! link GitGutterChange CoralboxAquaSign
hi! link GitGutterDelete CoralboxRedSign
hi! link GitGutterChangeDelete CoralboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile CoralboxGreen
hi! link gitcommitDiscardedFile CoralboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd CoralboxGreenSign
hi! link SignifySignChange CoralboxAquaSign
hi! link SignifySignDelete CoralboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign CoralboxRedSign
hi! link SyntasticWarningSign CoralboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   CoralboxBlueSign
hi! link SignatureMarkerText CoralboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl CoralboxBlueSign
hi! link ShowMarksHLu CoralboxBlueSign
hi! link ShowMarksHLo CoralboxBlueSign
hi! link ShowMarksHLm CoralboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch CoralboxYellow
hi! link CtrlPNoEntries CoralboxRed
hi! link CtrlPPrtBase CoralboxBg2
hi! link CtrlPPrtCursor CoralboxBlue
hi! link CtrlPLinePre CoralboxBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket CoralboxFg3
hi! link StartifyFile CoralboxFg1
hi! link StartifyNumber CoralboxBlue
hi! link StartifyPath CoralboxGray
hi! link StartifySlash CoralboxGray
hi! link StartifySection CoralboxYellow
hi! link StartifySpecial CoralboxBg2
hi! link StartifyHeader CoralboxOrange
hi! link StartifyFooter CoralboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign CoralboxRedSign
hi! link ALEWarningSign CoralboxYellowSign
hi! link ALEInfoSign CoralboxBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail CoralboxAqua
hi! link DirvishArg CoralboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir CoralboxAqua
hi! link netrwClassify CoralboxAqua
hi! link netrwLink CoralboxGray
hi! link netrwSymLink CoralboxFg1
hi! link netrwExe CoralboxYellow
hi! link netrwComment CoralboxGray
hi! link netrwList CoralboxBlue
hi! link netrwHelpCmd CoralboxAqua
hi! link netrwCmdSep CoralboxFg3
hi! link netrwVersion CoralboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir CoralboxAqua
hi! link NERDTreeDirSlash CoralboxAqua

hi! link NERDTreeOpenable CoralboxOrange
hi! link NERDTreeClosable CoralboxOrange

hi! link NERDTreeFile CoralboxFg1
hi! link NERDTreeExecFile CoralboxYellow

hi! link NERDTreeUp CoralboxGray
hi! link NERDTreeCWD CoralboxGreen
hi! link NERDTreeHelp CoralboxFg1

hi! link NERDTreeToggleOn CoralboxGreen
hi! link NERDTreeToggleOff CoralboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded CoralboxGreen
hi! link diffRemoved CoralboxRed
hi! link diffChanged CoralboxAqua

hi! link diffFile CoralboxOrange
hi! link diffNewFile CoralboxYellow

hi! link diffLine CoralboxBlue

" }}}
" Html: {{{

hi! link htmlTag CoralboxBlue
hi! link htmlEndTag CoralboxBlue

hi! link htmlTagName CoralboxAquaBold
hi! link htmlArg CoralboxAqua

hi! link htmlScriptTag CoralboxPurple
hi! link htmlTagN CoralboxFg1
hi! link htmlSpecialTagName CoralboxAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar CoralboxOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag CoralboxBlue
hi! link xmlEndTag CoralboxBlue
hi! link xmlTagName CoralboxBlue
hi! link xmlEqual CoralboxBlue
hi! link docbkKeyword CoralboxAquaBold

hi! link xmlDocTypeDecl CoralboxGray
hi! link xmlDocTypeKeyword CoralboxPurple
hi! link xmlCdataStart CoralboxGray
hi! link xmlCdataCdata CoralboxPurple
hi! link dtdFunction CoralboxGray
hi! link dtdTagName CoralboxPurple

hi! link xmlAttrib CoralboxAqua
hi! link xmlProcessingDelim CoralboxGray
hi! link dtdParamEntityPunct CoralboxGray
hi! link dtdParamEntityDPunct CoralboxGray
hi! link xmlAttribPunct CoralboxGray

hi! link xmlEntity CoralboxOrange
hi! link xmlEntityPunct CoralboxOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation CoralboxOrange
hi! link vimBracket CoralboxOrange
hi! link vimMapModKey CoralboxOrange
hi! link vimFuncSID CoralboxFg3
hi! link vimSetSep CoralboxFg3
hi! link vimSep CoralboxFg3
hi! link vimContinue CoralboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword CoralboxBlue
hi! link clojureCond CoralboxOrange
hi! link clojureSpecial CoralboxOrange
hi! link clojureDefine CoralboxOrange

hi! link clojureFunc CoralboxYellow
hi! link clojureRepeat CoralboxYellow
hi! link clojureCharacter CoralboxAqua
hi! link clojureStringEscape CoralboxAqua
hi! link clojureException CoralboxRed

hi! link clojureRegexp CoralboxAqua
hi! link clojureRegexpEscape CoralboxAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen CoralboxFg3
hi! link clojureAnonArg CoralboxYellow
hi! link clojureVariable CoralboxBlue
hi! link clojureMacro CoralboxOrange

hi! link clojureMeta CoralboxYellow
hi! link clojureDeref CoralboxYellow
hi! link clojureQuote CoralboxYellow
hi! link clojureUnquote CoralboxYellow

" }}}
" C: {{{

hi! link cOperator CoralboxPurple
hi! link cStructure CoralboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin CoralboxOrange
hi! link pythonBuiltinObj CoralboxOrange
hi! link pythonBuiltinFunc CoralboxOrange
hi! link pythonFunction CoralboxAqua
hi! link pythonDecorator CoralboxRed
hi! link pythonInclude CoralboxBlue
hi! link pythonImport CoralboxBlue
hi! link pythonRun CoralboxBlue
hi! link pythonCoding CoralboxBlue
hi! link pythonOperator CoralboxRed
hi! link pythonException CoralboxRed
hi! link pythonExceptions CoralboxPurple
hi! link pythonBoolean CoralboxPurple
hi! link pythonDot CoralboxFg3
hi! link pythonConditional CoralboxRed
hi! link pythonRepeat CoralboxRed
hi! link pythonDottedName CoralboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces CoralboxBlue
hi! link cssFunctionName CoralboxYellow
hi! link cssIdentifier CoralboxOrange
hi! link cssClassName CoralboxGreen
hi! link cssColor CoralboxBlue
hi! link cssSelectorOp CoralboxBlue
hi! link cssSelectorOp2 CoralboxBlue
hi! link cssImportant CoralboxGreen
hi! link cssVendor CoralboxFg1

hi! link cssTextProp CoralboxAqua
hi! link cssAnimationProp CoralboxAqua
hi! link cssUIProp CoralboxYellow
hi! link cssTransformProp CoralboxAqua
hi! link cssTransitionProp CoralboxAqua
hi! link cssPrintProp CoralboxAqua
hi! link cssPositioningProp CoralboxYellow
hi! link cssBoxProp CoralboxAqua
hi! link cssFontDescriptorProp CoralboxAqua
hi! link cssFlexibleBoxProp CoralboxAqua
hi! link cssBorderOutlineProp CoralboxAqua
hi! link cssBackgroundProp CoralboxAqua
hi! link cssMarginProp CoralboxAqua
hi! link cssListProp CoralboxAqua
hi! link cssTableProp CoralboxAqua
hi! link cssFontProp CoralboxAqua
hi! link cssPaddingProp CoralboxAqua
hi! link cssDimensionProp CoralboxAqua
hi! link cssRenderProp CoralboxAqua
hi! link cssColorProp CoralboxAqua
hi! link cssGeneratedContentProp CoralboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces CoralboxFg1
hi! link javaScriptFunction CoralboxAqua
hi! link javaScriptIdentifier CoralboxRed
hi! link javaScriptMember CoralboxBlue
hi! link javaScriptNumber CoralboxPurple
hi! link javaScriptNull CoralboxPurple
hi! link javaScriptParens CoralboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport CoralboxAqua
hi! link javascriptExport CoralboxAqua
hi! link javascriptClassKeyword CoralboxAqua
hi! link javascriptClassExtends CoralboxAqua
hi! link javascriptDefault CoralboxAqua

hi! link javascriptClassName CoralboxYellow
hi! link javascriptClassSuperName CoralboxYellow
hi! link javascriptGlobal CoralboxYellow

hi! link javascriptEndColons CoralboxFg1
hi! link javascriptFuncArg CoralboxFg1
hi! link javascriptGlobalMethod CoralboxFg1
hi! link javascriptNodeGlobal CoralboxFg1
hi! link javascriptBOMWindowProp CoralboxFg1
hi! link javascriptArrayMethod CoralboxFg1
hi! link javascriptArrayStaticMethod CoralboxFg1
hi! link javascriptCacheMethod CoralboxFg1
hi! link javascriptDateMethod CoralboxFg1
hi! link javascriptMathStaticMethod CoralboxFg1

" hi! link javascriptProp CoralboxFg1
hi! link javascriptURLUtilsProp CoralboxFg1
hi! link javascriptBOMNavigatorProp CoralboxFg1
hi! link javascriptDOMDocMethod CoralboxFg1
hi! link javascriptDOMDocProp CoralboxFg1
hi! link javascriptBOMLocationMethod CoralboxFg1
hi! link javascriptBOMWindowMethod CoralboxFg1
hi! link javascriptStringMethod CoralboxFg1

hi! link javascriptVariable CoralboxOrange
" hi! link javascriptVariable CoralboxRed
" hi! link javascriptIdentifier CoralboxOrange
" hi! link javascriptClassSuper CoralboxOrange
hi! link javascriptIdentifier CoralboxOrange
hi! link javascriptClassSuper CoralboxOrange

" hi! link javascriptFuncKeyword CoralboxOrange
" hi! link javascriptAsyncFunc CoralboxOrange
hi! link javascriptFuncKeyword CoralboxAqua
hi! link javascriptAsyncFunc CoralboxAqua
hi! link javascriptClassStatic CoralboxOrange

hi! link javascriptOperator CoralboxRed
hi! link javascriptForOperator CoralboxRed
hi! link javascriptYield CoralboxRed
hi! link javascriptExceptions CoralboxRed
hi! link javascriptMessage CoralboxRed

hi! link javascriptTemplateSB CoralboxAqua
hi! link javascriptTemplateSubstitution CoralboxFg1

" hi! link javascriptLabel CoralboxBlue
" hi! link javascriptObjectLabel CoralboxBlue
" hi! link javascriptPropertyName CoralboxBlue
hi! link javascriptLabel CoralboxFg1
hi! link javascriptObjectLabel CoralboxFg1
hi! link javascriptPropertyName CoralboxFg1

hi! link javascriptLogicSymbols CoralboxFg1
hi! link javascriptArrowFunc CoralboxYellow

hi! link javascriptDocParamName CoralboxFg4
hi! link javascriptDocTags CoralboxFg4
hi! link javascriptDocNotation CoralboxFg4
hi! link javascriptDocParamType CoralboxFg4
hi! link javascriptDocNamedParamType CoralboxFg4

hi! link javascriptBrackets CoralboxFg1
hi! link javascriptDOMElemAttrs CoralboxFg1
hi! link javascriptDOMEventMethod CoralboxFg1
hi! link javascriptDOMNodeMethod CoralboxFg1
hi! link javascriptDOMStorageMethod CoralboxFg1
hi! link javascriptHeadersMethod CoralboxFg1

hi! link javascriptAsyncFuncKeyword CoralboxRed
hi! link javascriptAwaitFuncKeyword CoralboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword CoralboxAqua
hi! link jsExtendsKeyword CoralboxAqua
hi! link jsExportDefault CoralboxAqua
hi! link jsTemplateBraces CoralboxAqua
hi! link jsGlobalNodeObjects CoralboxFg1
hi! link jsGlobalObjects CoralboxFg1
hi! link jsFunction CoralboxAqua
hi! link jsFuncParens CoralboxFg3
hi! link jsParens CoralboxFg3
hi! link jsNull CoralboxPurple
hi! link jsUndefined CoralboxPurple
hi! link jsClassDefinition CoralboxYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved CoralboxAqua
hi! link typeScriptLabel CoralboxAqua
hi! link typeScriptFuncKeyword CoralboxAqua
hi! link typeScriptIdentifier CoralboxOrange
hi! link typeScriptBraces CoralboxFg1
hi! link typeScriptEndColons CoralboxFg1
hi! link typeScriptDOMObjects CoralboxFg1
hi! link typeScriptAjaxMethods CoralboxFg1
hi! link typeScriptLogicSymbols CoralboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects CoralboxFg1
hi! link typeScriptParens CoralboxFg3
hi! link typeScriptOpSymbols CoralboxFg3
hi! link typeScriptHtmlElemProperties CoralboxFg1
hi! link typeScriptNull CoralboxPurple
hi! link typeScriptInterpolationDelimiter CoralboxAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword CoralboxAqua
hi! link purescriptModuleName CoralboxFg1
hi! link purescriptWhere CoralboxAqua
hi! link purescriptDelimiter CoralboxFg4
hi! link purescriptType CoralboxFg1
hi! link purescriptImportKeyword CoralboxAqua
hi! link purescriptHidingKeyword CoralboxAqua
hi! link purescriptAsKeyword CoralboxAqua
hi! link purescriptStructure CoralboxAqua
hi! link purescriptOperator CoralboxBlue

hi! link purescriptTypeVar CoralboxFg1
hi! link purescriptConstructor CoralboxFg1
hi! link purescriptFunction CoralboxFg1
hi! link purescriptConditional CoralboxOrange
hi! link purescriptBacktick CoralboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp CoralboxFg3
hi! link coffeeSpecialOp CoralboxFg3
hi! link coffeeCurly CoralboxOrange
hi! link coffeeParen CoralboxFg3
hi! link coffeeBracket CoralboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter CoralboxGreen
hi! link rubyInterpolationDelimiter CoralboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier CoralboxRed
hi! link objcDirective CoralboxBlue

" }}}
" Go: {{{

hi! link goDirective CoralboxAqua
hi! link goConstants CoralboxPurple
hi! link goDeclaration CoralboxRed
hi! link goDeclType CoralboxBlue
hi! link goBuiltins CoralboxOrange

" }}}
" Lua: {{{

hi! link luaIn CoralboxRed
hi! link luaFunction CoralboxAqua
hi! link luaTable CoralboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp CoralboxFg3
hi! link moonExtendedOp CoralboxFg3
hi! link moonFunction CoralboxFg3
hi! link moonObject CoralboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation CoralboxBlue
hi! link javaDocTags CoralboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen CoralboxFg3
hi! link javaParen1 CoralboxFg3
hi! link javaParen2 CoralboxFg3
hi! link javaParen3 CoralboxFg3
hi! link javaParen4 CoralboxFg3
hi! link javaParen5 CoralboxFg3
hi! link javaOperator CoralboxOrange

hi! link javaVarArg CoralboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter CoralboxGreen
hi! link elixirInterpolationDelimiter CoralboxAqua

hi! link elixirModuleDeclaration CoralboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition CoralboxFg1
hi! link scalaCaseFollowing CoralboxFg1
hi! link scalaCapitalWord CoralboxFg1
hi! link scalaTypeExtension CoralboxFg1

hi! link scalaKeyword CoralboxRed
hi! link scalaKeywordModifier CoralboxRed

hi! link scalaSpecial CoralboxAqua
hi! link scalaOperator CoralboxFg1

hi! link scalaTypeDeclaration CoralboxYellow
hi! link scalaTypeTypePostDeclaration CoralboxYellow

hi! link scalaInstanceDeclaration CoralboxFg1
hi! link scalaInterpolation CoralboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 CoralboxGreenBold
hi! link markdownH2 CoralboxGreenBold
hi! link markdownH3 CoralboxYellowBold
hi! link markdownH4 CoralboxYellowBold
hi! link markdownH5 CoralboxYellow
hi! link markdownH6 CoralboxYellow

hi! link markdownCode CoralboxAqua
hi! link markdownCodeBlock CoralboxAqua
hi! link markdownCodeDelimiter CoralboxAqua

hi! link markdownBlockquote CoralboxGray
hi! link markdownListMarker CoralboxGray
hi! link markdownOrderedListMarker CoralboxGray
hi! link markdownRule CoralboxGray
hi! link markdownHeadingRule CoralboxGray

hi! link markdownUrlDelimiter CoralboxFg3
hi! link markdownLinkDelimiter CoralboxFg3
hi! link markdownLinkTextDelimiter CoralboxFg3

hi! link markdownHeadingDelimiter CoralboxOrange
hi! link markdownUrl CoralboxPurple
hi! link markdownUrlTitleDelimiter CoralboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType CoralboxYellow
" hi! link haskellOperators CoralboxOrange
" hi! link haskellConditional CoralboxAqua
" hi! link haskellLet CoralboxOrange
"
hi! link haskellType CoralboxGreen
hi! link haskellIdentifier CoralboxFg1
hi! link haskellSeparator CoralboxFg1
hi! link haskellDelimiter CoralboxFg4
hi! link haskellOperators CoralboxBlue
"
hi! link haskellBacktick CoralboxOrange
hi! link haskellStatement CoralboxOrange
hi! link haskellConditional CoralboxOrange

hi! link haskellLet CoralboxAqua
hi! link haskellDefault CoralboxAqua
hi! link haskellWhere CoralboxAqua
hi! link haskellBottom CoralboxAqua
hi! link haskellBlockKeywords CoralboxAqua
hi! link haskellImportKeywords CoralboxAqua
hi! link haskellDeclKeyword CoralboxAqua
hi! link haskellDeriving CoralboxAqua
hi! link haskellAssocType CoralboxAqua

hi! link haskellNumber CoralboxPurple
hi! link haskellPragma CoralboxPurple

hi! link haskellString CoralboxGreen
hi! link haskellChar CoralboxGreen

" }}}
" Json: {{{

hi! link jsonKeyword CoralboxGreen
hi! link jsonQuote CoralboxGreen
hi! link jsonBraces CoralboxFg1
hi! link jsonString CoralboxFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! CoralboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! CoralboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
