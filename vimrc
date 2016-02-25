if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif






set nocompatible	" Use Vim defaults (much better!)
filetype off		" Required
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time



" Karlis Modificatioons

" # PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jaywilliams/vim-vwilight'
Plugin 'mattn/emmet-vim' 
Plugin 'tpope/vim-commentary'			" allows to comment with shortcuts
Plugin 'Raimondi/delimitMate'			" automatically create end brackets
Plugin 'cakebaker/scss-syntax.vim'		" adds support for nested styles
Plugin 'gorodinskiy/vim-coloresque'		" highlights colors #hex, rgb() etc.
Plugin 'scrooloose/syntastic'			" syntax checker


call vundle#end()
filetype plugin indent on " Required

" # STANDARD VIM SETTINGS
set title 		" 
set number		" line numbers
set tabstop=4 		" default 8 

" # SETTING MODULES
" <missing description>


" ## COLOR SCHEME
set t_Co=256 		" force terminal use 256 colors
syntax enable		" switches on syntax highlighting
set background=dark
" colorscheme predawn
" colorscheme vwilight
colorscheme monokai " atleast works


" ## EMMET

" disable emmet in all modes
let g:user_emmet_install_global = 0

let g:user_emmet_expandabbr_key = '<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:use_emmet_complete_tag = 1

autocmd FileType html,css,scss,php,tt EmmetInstall
" enable emmet only on specified types

" ## DELIMIT MATE
" provides automatic closing of quotes, parenthesis, brackets
let g:delimitMate_expand_cr = 1			" {|} -space-> { | }
let g:delimitMate_expand_space = 1		" {|} -tab-> { new-line | new-line }
let g:delimitMate_autoclose = 1			" when adding { it adds } automatically
" inoremap {<cr> {<cr>}<c-o>O<tab>
" inoremap [<cr> [<cr>]<c-o>O<tab>
" inoremap (<cr> (<cr>)<c-o>O<tab>

" ## SYNTASTIC


" eof Karlis Modifications












" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
