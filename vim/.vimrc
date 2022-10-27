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
"colorscheme jellybeans
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
set ignorecase
"set clipboard^=unnamed,unnamedplus
set clipboard=unnamedplus
set hidden
set cmdheight=2 
set number
set history=200
syntax on
set relativenumber
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Advanced configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=longest,list,full
"fix indentation in yaml files (yaml req. 2 space indentation) important for docker compose
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
"Set default colorscheme for airline plugin
"See https://github.com/vim-airline/vim-airline-themes for reference
let g:airline_theme='gruvbox'
"###############################################################
" PLUGIN CONFIGURATION FOR MARKDOWN-PREVIEW SEE
" https://github.com/iamcco/markdown-preview.nvim for reference
"###############################################################
" ############              CONFIG                   ##########
"###############################################################
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

"###############################################################
" PLUGIN CONFIGURATION FOR MARKDOWN-PREVIEW SEE
" https://github.com/iamcco/markdown-preview.nvim for reference
"###############################################################
" ############    KEYMAPPINGS for MARKDOWN-PREVIEW    ##########
"###############################################################
" normal/insert
"<Plug>MarkdownPreview
"<Plug>MarkdownPreviewStop
"<Plug>MarkdownPreviewToggle

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

"###############################################################
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
"Custom keymapping for coding on german keyboards:
inoremap ö (
inoremap Ö )
inoremap ä [
inoremap Ä ]
inoremap ü {
inoremap Ü }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin manager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
"Simple Motions https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion'
"Disctraction-free writing in vim https://github.com/junegunn/goyo.vim
Plug 'junegunn/goyo.vim'
"Codesnippets in vim https://github.com/SirVer/ultisnips
Plug 'SirVEr/ultisnips' | Plug 'honza/vim-snippets'
"Pretty status/tabline for vim https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
"A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
" Markdown live preview https://github.com/iamcco/markdown-preview.nvim
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"surround.vim Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'tpope/vim-surround'
"Personal Wiki for Vim https://github.com/vimwiki/vimwiki
" resource: http://vimwiki.github.io/
Plug 'vimwiki/vimwiki'
"Retro groove color scheme for Vim
" see: https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'
call plug#end()
"Gruvbox colorscheme initialization
autocmd vimenter * ++nested colorscheme gruvbox
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
