" load vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

"Mouse mode on
set mouse=a

" Exit insert mode
inoremap kj <Esc>
inoremap jk <Esc>
inoremap <C-c> <Esc>


" save current buffer
nmap gs :w<CR>

filetype plugin indent on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set showmatch
set incsearch

let mapleader = ','
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plug 'tpope/vim-commentary'
Plug 'wesQ3/vim-windowswap'
Plug 'rking/ag.vim'

" The following are examples of different formats supported.  Keep Plugin
" commands between vundle#begin/end.'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-surround'
Plug 'tstelzer/welpe.vim'
Plug 'ninja/sky'
Plug 'mhinz/vim-startify'
Plug 'sjl/gundo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jacoborus/tender'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call plug#end()            " required filetype plugin indent on
" required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help :PluginList       - lists configured plugins :PluginInstall    -
" installs plugins; append `!` to update or just :PluginUpdate :PluginSearch
" foo - searches for foo; append `!` to refresh local cache :PluginClean
" - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ " Put your non-Plugin stuff
" after this line
" --------------------------------------------------------------------------------
"
" color spiderhawk
" color welpe
" color sky
color tender
" color solarized
set background=dark

syntax on

nmap <leader>g :Ag
nmap <C-p> :FZF<CR>

" Change the status bar and vert split color
hi VertSplit ctermbg=235 ctermfg=black
hi StatusLine ctermbg=235 ctermfg=039
hi StatusLineNC ctermbg=235 ctermfg=black
hi Normal ctermbg=none
hi Visual ctermbg=244 ctermfg=white
hi Search ctermbg=244 ctermfg=white

" Random thing
iab functino function

" improve popup menu color
:highlight Pmenu ctermbg=238 ctermfg=67 gui=bold

set laststatus=2
" put useful info in status bar
silent! call fugitive#statusline()
if exists("*fugitive#statusline")
    set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
endif

" change current line color when in insert mode
autocmd InsertEnter * set cursorline
autocmd InsertEnter * hi CursorLine cterm=NONE ctermbg=17 ctermfg=none
autocmd InsertLeave * set nocursorline

" yank into clipboard
noremap gy "+y

" Jump 5 lines up
nmap K :-5<CR>

" Jump 5 lines down
nmap J :+5<CR>

" paste mode
nmap gp :set paste<CR>
nmap gP :set nopaste<CR>

" Switching between buffers
noremap gh <C-w>h
noremap gj <C-w>j
noremap gk <C-w>k
noremap gl <C-w>l

" tab navigation
nnoremap <leader>m :tabn<CR>
nnoremap <leader>p :tabp<CR>
nnoremap <C-t> :tabnew<CR>

" Terminal remaps
tnoremap qq <C-\><C-n>:call FloatDown()<CR>

nmap ge :NERDTreeToggle<CR>
nmap gq :q<CR>

nnoremap <leader>e :call EditVimrc()<CR>

" command to open vimrc
function! EditVimrc()
    if bufname('%') == '' &&  line('$') == 1 && getline(1) == ''
        " buffer is empty and is unnamed, open in current window
        :e $MYVIMRC
    else
        " check window dimensions
        let l:height = winheight(0) * 2
        let l:width = winwidth(0)
        if (l:height > l:width)
            :split $MYVIMRC
        else
            :vsplit $MYVIMRC
        endif
    endif
endfunction


"-----

" Close nerdtree when opening file
let NERDTreeQuitOnOpen = 1

let g:indentLine_color_term = 0
let g:indentLine_char = '|'

" move to the tast non whitespace line (for exiting terminal inset mode)
function! FloatDown()
    norm L
    while line(".") > 0
                \ && (strlen(getline(".")) < col(".")
                \ || getline(".")[col(".") -1 ] =~ '\s')
        norm k
    endwhile
    norm $
endfunction
