" Document layout {{{

" vim:foldmethod=marker:foldlevel=0

" }}}
" Vundle Plugin Load {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'                   " required
Plugin 'tpope/vim-fugitive'                  " git commands
Plugin 'davidhalter/jedi-vim'                " jedi vim
Plugin 'tpope/vim-surround'                  " quick replace
Plugin 'lervag/vimtex'                       " LaTeX ligth-IDE
Plugin 'vim-syntastic/syntastic'             " syntax linter use ALE
Plugin 'scrooloose/nerdtree'                 " dir tree
Plugin 'jnurmine/Zenburn'                    " zenburn color
Plugin 'altercation/vim-colors-solarized'    " solarized color
Plugin 'vim-airline/vim-airline'             " status bar
Plugin 'vim-airline/vim-airline-themes'      " themes
" Plugin 'Valloric/YouCompleteMe'              " auto-complete
Plugin 'nvie/vim-flake8'                     " PEP8 code check
Plugin 'vim-scripts/indentpython.vim'        " Python intendation
Plugin 'tmhedberg/SimpylFold'                " A better folder
Plugin 'sjl/gundo.vim'                       " Graphical undo
Plugin 'w0rp/ale'                            " On the fly linter
Plugin 'chriskempson/base16-vim'             " Base-16 colors


call vundle#end()            " required
filetype plugin indent on    " required

" }}}
"  Keybindings {{{

" Reset <leader> to>,
let mapleader=","

" Code completion on ,<tab>
imap <leader><tab> <C-x><C-o>
imap  <C-o>

"Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
nmap … ddkP
nmap – ddp

"Bubble multiple lines
vmap … ddkP xkP`[V`]
vmap – xp`[V`]

" New line below
nnoremap <Enter> o<Esc>x

" New line above - is this working?
nmap <S-Enter> O<Esc>x

" use ,<space> to remove search highlights
nnoremap <leader><space> :nohlsearch<CR>

" space open/closes folds
nnoremap <space> za

" Move per visual line (ignore line breaks)
nnoremap j gj
nnoremap k gk

" End of line and beginning of line
nnoremap E $
nnoremap B 0

" Kill arrows
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" Tab settings 
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" highlight last inserted text
nnoremap gv `[v`]

" Save with ,w
" nnoremap <leader>w <esc>:w<CR> 
" inoremap <leader>w <esc>:w<CR> 
" vnoremap <leader>w <esc>:w<CR> 

" Replace word with with ,r
" nnoremap <leader>r kpldwb

" Align
nnoremap <leader>J k$Jxi<enter><esc>

" jj is escape
inoremap jj <esc>

" toggle gundo with ,u
" nnoremap ,u :GundoToggle<CR>

" NERDTree Toggle
nmap <leader>nt :NERDTreeToggle <CR>
" NERDTRee show hidden files
let NERDTreeShowHidden=1

" ALE iterate through errors
nmap <silent> <C-A> <Plug>(ale_previous_wrap)
nmap <silent> <C-a> <Plug>(ale_next_wrap)

" retry compile with ,l
nnoremap ,l :VimtexCompile<CR> 

" }}}
" Settings {{{

" YouCompleteMe
" let g:ycm_python_binary_path = '/Users/flnr/anaconda/bin/python'
" let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ALE
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '%linter% %s'

" Fold previews
let g:SimpylFold_docstring_preview=1

" Turn on spell checking
" set spell spelllang=en_us

" Fix Gundo for Python 3
let g:gundo_prefer_python3 = 1

" Trailing spaces
autocmd FileType python,tex,c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e

" Intendation
set tabstop=2                          " <TAB> = 4 <SPACE>
set softtabstop=2                      " <TAB> spacing in editing 
set expandtab                          " expand tabs into spaces

" Folding
set foldenable                         " Enable folding
set foldlevelstart=10                  " Open most folds by default
set foldnestmax=10                     " 10 nested fold max
set foldmethod=indent                  " Fold based on indent level

" File behavior
set encoding=utf-8                     " Default to utf-8

" Screen behavior
set lazyredraw                         " Lazy redraw of screen
set showmatch                          " Autoblink on parenthesis
set wildmenu                           " Graphical autocomplete
set nu                                 " Line numbering

" Search behavior
set incsearch                          " Search as chars are entered
set hlsearch                           " Highlight matches

" Color behavior
syntax enable                 " syntax highlighting
" let base16colorspace=256
" colorscheme solarized-dark 
let g:airline_theme='base16'        " Status bar theme
let g:airline_solarized_bg='dark'      " solarized statusbar
let python_highlight_all=1             " Python highlighting
let NERDTreeIgnore=['\.pyc$', '\~$']   "ignore in NERDTree

" Modified highlighting
hi MatchParen cterm=bold gui=bold ctermbg=none guibg=NONE ctermfg=magenta guifg=DarkMagenta

" GUI settings
" defaults write org.vim.MacVim AppleFontSmoothing -int 0
if has('gui_running')
  set timeout timeoutlen=1000 ttimeoutlen=100     " Slow down key timeout
  set vb t_vb=                                    " Turn off mvim alarm bell
  imap jj <esc>  
endif

" LaTex
let g:vimtex_view_method='skim'        " Use Skim as previewer
let g:vimtex_complete_close_braces=1   " Autocomplete braces
let g:vimtex_indent_enables=0          " Disable autoindent

" Python
" autocmd BufWritePost *.py call Flake8() " Run on write 

" Change cursor
if &term =~ "xterm\\|rxvt"
  " solid vertical bar
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 2 -> solid underscore 
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar  
endif

" }}}
" Filetype settings {{{

au BufNewFile,BufRead *.py
    \ set tabstop=4       |                  " <TAB> = 4 <SPACE>
    \ set softtabstop=4   |                  " <TAB> spacing in editing 
    \ set shiftwidth=4    |
    \ set textwidth=79    |
    \ set fileformat=unix |
    \ set autoindent      |

au BufNewFile,BufRead *.tex
    \ filetype indent off |
    \ filetype plugin on  |
    \ set filetype=tex |
    \ hi SpellBad cterm=underline ctermfg=15 guifg=White |
    \ hi SpellCap cterm=underline ctermfg=15 guifg=White |
    \ nnoremap ,e i\begin{equation}|
    \ imap ,e \begin{equation}|
    \ imap ,l \label{|
    \ imap ,c ~\cite{|

" }}}


