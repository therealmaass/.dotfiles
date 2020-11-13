"           _
"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
"     \ V /| | | | | | | | | (__
"      \_/ |_|_| |_| |_|_|  \___|
"
"       Vim configuration smaass
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Standard Stuff 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme jellybeans
"filetype plugin indent on
filetype off
set nocompatible
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set showmode
set showmatch
set showcmd
set ruler
set nojoinspaces
"set cpo+=$
set whichwrap+=<,>
set mousehide
set hlsearch
set incsearch
"set clipboard^=unnamed,unnamedplus
set clipboard=unnamedplus
set hidden
set cmdheight=2 
set number
set history=200
syntax on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Advanced configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=longest,list,full
"fix indentation in yaml files (yaml req. 2 space indentation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set prefix for plugin https://github.com/easymotion/vim-easymotion
map <Leader> <Plug>(easymotion-prefix)
"Set prefix f for plugin https://github.com/junegunn/goyo.vim for disctraction free buffer view 
map <Leader>f :Goyo \| set linebreak<CR>
"Set Tab jumping for https://github.com/SirVer/ultinips
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set help jumps to F11 
map <F11> <C-]>
"Open my vimrc
nmap <silent> ,ev :e ~/.vimrc<CR>
"Source my vimrc
nmap <silent> ,sv :so ~/.vimrc<CR>
"Backqoutes to jump to a mark
nmap <silent> à `a 
nmap <silent> è `e
nmap <silent> ì `i
nmap <silent> ò `o
nmap <silent> ù `u
"Use the arows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>
"Exit insert mode with jj
inoremap jj <ESC>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin manager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'SirVEr/ultisnips' | Plug 'honza/vim-snippets'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WSL yank support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
           autocmd!
           autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
