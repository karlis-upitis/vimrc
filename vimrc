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
Plugin 'mattn/emmet-vim'                " emmet
Plugin 'tpope/vim-commentary'           " comment with shortcuts
Plugin 'Raimondi/delimitMate'           " automatically create end brackets
Plugin 'cakebaker/scss-syntax.vim'      " adds support for nested styles
Plugin 'scrooloose/syntastic'           " syntax checker
Plugin 'bling/vim-airline'				" status bar
Plugin 'terryma/vim-multiple-cursors'   " multiple cursor support
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'          " NerdTree (file system visualisation)

" colors & hihlighting
Plugin 'nelsyeung/twig.vim'
Plugin 'jaywilliams/vim-vwilight'       " theme colors
Plugin 'gorodinskiy/vim-coloresque'     " highlights colors #hex, rgb() etc.

call vundle#end()
filetype plugin indent on " Required

" General settings
" =====================
set title
set noswapfile                          " no .swp files
set nobackup
set nowrap
set autoindent 							" always set autoindenting on"
"set number      						" line numbers
set scrolloff=5 " set scroll context

" Tabs
" ----
" Special settings for HTML/CSS related files
autocmd FileType html,css,scss,tt,tt2,twig :set shiftwidth=4 tabstop=4
autocmd FileType html,css,scss,tt,tt2,twig :imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" General Tabbing settings
set shiftwidth=2		
set tabstop=2       					" tell vim how many columns a tab counts for

" Search
" ------
set hlsearch  " Highlight search results
set incsearch " Make search jump:

" Split Window
" ------------
set splitbelow                         " puts new splits to the bottom
set splitright                          " ensures new splits are to the right of current

" Autocomplete
" ------------
set wildmenu 							"TEST: visually autocomplete the command menu"
" set breakindent 						" Make word wrapping behave like it does in every other sane text editor



" # SETTING MODULES
" <missing description>


" ## COLOR SCHEME
set t_Co=256        " force terminal use 256 colors
syntax enable       " switches on syntax highlighting
set background=dark
colorscheme predawn
" colorscheme vwilight
" colorscheme monokai " atleast works

" ## Split window
noremap <Leader>h :split<CR>
noremap <Leader>v :vsplit<CR>

noremap <C-J> <C-W><C-J> " navigate to bottom split 	
noremap <C-K> <C-W><C-K> " navigate to top split
noremap <C-L> <C-W><C-L> " navigate to right split
noremap <C-H> <C-W><C-H> " navigate to left split



" ## EMMET

" disable emmet in all modes
let g:user_emmet_install_global = 0
let g:user_emmet_expandabbr_key = '<Tab>'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"use emmetExpandSmart way (so we can use tab to ident as well)
let g:user_emmet_complete_tag = 1

autocmd FileType html,css,scss,php,tt,tt2,twig EmmetInstall
" enable emmet only on specified types

" ## DELIMIT MATE
" provides automatic closing of quotes, parenthesis, brackets
let g:delimitMate_expand_cr = 1         " {|} -space-> { | }
let g:delimitMate_expand_space = 1      " {|} -tab-> { new-line | new-line }
let g:delimitMate_autoclose = 1         " when adding { it adds } automatically

" ## SYNTASTIC
" doesn't work? Check why with :SyntasticInfo
"let g:syntastic_debug = 1 				" Let you debug if scss-lint is loaded
" TODO: double check if this WORKS
let g:syntastic_scss_checkers = ['scss_lint']
" let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '!'

" vim tries to find .scss-lint.yml file from current location
" not the root where .scss-lint.yml is stored. This solves the issue
" https://github.com/scrooloose/syntastic/issues/1373
fun! SetScssConfig()
    let scssConfig = findfile('.scss-lint.yml', '.;')
    if scssConfig != ''
        let b:syntastic_scss_scss_lint_args = '--config ' . scssConfig
    endif
endf

" autocommands
if !exists("autocommands_loaded")
    let autocommands_loaded = 1
	" reload .vimrc automatically
    autocmd BufWritePost  .vimrc         source %
    autocmd BufWritePost  vimrc.dotfile  source %
	" different changes
	autocmd FileType scss :call SetScssConfig()
endif


" ## STATUS BAR - AIRLINE
set laststatus=2 						" Enable the status bar to always show"
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
"let g:airline_theme="molokai" 
let g:airline#extensions#tabline#enabled = 1 		"enable the tabline
let g:airline#extensions#tabline#fnamemod = ':t' 	" show just the filename of buffers in the tab line
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ## YouCompleteMe (pretty heavy lib for autocomplete)

" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_key_invoke_completion = '<C-Space>'

" ## Highlight redundant whitespaces and tabs.
" Only shows trailing whitespace :)

highlight RedundantSpaces ctermbg=red
match RedundantSpaces /\s\+$/

" ## VIM MULTIPLE CURSORS

let g:multi_cursor_exit_from_insert_mode = 0   "To not loose all existing cursors when pressing <ESC> 
let g:multi_cursor_start_key='<C-d>'

" ## NERDTREE
map <C-n> :NERDTreeToggle<CR> " Enable Nerdtree with CTRL + N

" git-vim-automatically-wrap-long-commit-messages
au FileType gitcommit setlocal tw=72
