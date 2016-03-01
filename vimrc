if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif


set nocompatible            " Use Vim defaults (much better!)
filetype off                " Required for Vundle
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set viminfo='20,\"50        " read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set history=50              " keep 50 lines of command line history
set ruler                   " show the cursor position all the time




" # PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'           " required for vundle ;)
Plugin 'jaywilliams/vim-vwilight'       " theme colors
Plugin 'mattn/emmet-vim'                " emmet
Plugin 'tpope/vim-commentary'           " comment with shortcuts
Plugin 'Raimondi/delimitMate'           " automatically create end brackets
Plugin 'cakebaker/scss-syntax.vim'      " adds support for nested styles
Plugin 'gorodinskiy/vim-coloresque'     " highlights colors #hex, rgb() etc.
Plugin 'scrooloose/syntastic'           " syntax checker


call vundle#end()
filetype plugin indent on " Required

" # STANDARD VIM SETTINGS
set title       "
set number      " line numbers
set tabstop=4       " default 8

" # SETTING MODULES
" <missing description>


" ## COLOR SCHEME
set t_Co=256        " force terminal use 256 colors
syntax enable       " switches on syntax highlighting
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
let g:delimitMate_expand_cr = 1         " {|} -space-> { | }
let g:delimitMate_expand_space = 1      " {|} -tab-> { new-line | new-line }
let g:delimitMate_autoclose = 1         " when adding { it adds } automatically

" ## SYNTASTIC
" doesn't work? Check why with :SyntasticInfo
let g:syntastic_debug = 1 				" Let you debug if scss-lint is loaded	
let g:syntastic_scss_checkers = ['scss_lint']
" let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '!'




