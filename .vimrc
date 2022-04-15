
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'guns/vim-sexp'
Plug 'guns/vim-clojure-static'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'branch': 'release/0.x'
  \ }
Plug 'dag/vim-fish'

call plug#end()

" General

set nocompatible
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set nu
filetype plugin on
filetype plugin indent on
set mouse=""
set noswapfile
set undodir=/tmp/.vimundo
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set number
set nowrap
set textwidth=79
set formatoptions=qrn1
set pastetoggle=<leader>p
set cmdwinheight=20
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set relativenumber
set wildignore+=*/tmp/*,*/out/*,*/target/*,*.so,*.swp,*.zip

let mapleader = ","
let maplocalleader = "f"
map <buffer> <LocalLeader>A  echo("sup")<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction

" switch buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

nnoremap H ^
nnoremap L $
vnoremap jk <esc>
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <leader>f va(
nnoremap z i<space><esc>
noremap <tab>] :tabnext <cr>
noremap <tab>[ :tabnext <cr>
noremap <leader>T :tabnew <cr>
noremap cpc :call Mx(0) <cr>

nnoremap <leader>t :! clear && yarn test-one %:p <cr>
nnoremap <leader>e :! clear && LOG_LEVEL=60 yarn --silent babel-node %:p <cr>
nnoremap <leader>bb :! clear && bb %:p <cr>

" Color

let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1
colorscheme sonokai

set background=dark
syntax enable
syntax on
set guifont=Inconsolata:h15

hi clear CursorLine
hi Cursor ctermfg=blue ctermbg=red
hi Normal guibg=#242932 guifg = #eff0ea
hi Conditional ctermfg = green
hi LineNr ctermfg = grey guibg=#242932 guifg=#686767
hi Function ctermfg = blue guifg=#88c0d0
hi Identifier ctermfg = blue guifg=#88c0d0
hi Statement ctermfg = blue guifg=#88c0d0
hi Statement ctermfg = cyan
hi Exception ctermfg = green
hi Special ctermfg = magenta
hi VertSplit ctermfg = 240 guibg=#242932
hi TabLineFill ctermfg = 240 guibg=#242932
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg = 240 guibg=#242932
hi Comment ctermfg = 240
hi String ctermfg = yellow
hi jsTemplateString ctermfg = blue
hi Type ctermfg = blue guifg=#88c0d0
hi Comment guifg=grey
hi CocErrorHighlight ctermfg=blue
hi CocUnderline ctermfg=blue
hi Pmenu ctermbg=none ctermfg=magenta guibg=magenta

" Filetypes

au BufRead,BufNewFile *.edn set syntax=clojure
au BufRead,BufNewFile Dockerfile set filetype=conf
autocmd FileType html,php,scss,css,javascript EmmetInstall

" Key Mappings

nnoremap ; :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>ft Vatzf
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>w <C-w>v<C-w><leader>t
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap % v% 
noremap <leader>r :Require<CR>
map - :Explore<CR>

" Emmet
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" because fish isn't bash compatible
if &shell =~# 'fish$'
  set shell=sh
endif

" Coc and Sexp Editing

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

nmap <leader>gd <Plug>(coc-definition)
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
nmap <leader>M ((<Plug>(sexp_insert_at_list_tail)<cr>
nmap <leader>g <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


" Clojure
let g:sexp_enable_insert_mode_mappings = 1
let g:clojure_fuzzy_indent_patterns = ['^doto', '^with', '^def', '^let', 'go-loop', 'match', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', 'this-as', '^are', '^dofor']
let g:clojure_align_multiline_strings = 1
let g:clojure_maxlines = 100
let g:clj_refactor_prefix_rewriting=0

nmap <Leader>F <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
nmap <Leader>f <Plug>FireplacePrint<Plug>(sexp_outer_list)``
nmap <Leader>e <Plug>FireplacePrint<Plug>(sexp_inner_element)``
nmap <Leader>d [<C-D>
nmap <Leader>E :%Eval<CR>
nmap <Leader>R cqp(require 'clojure.tools.namespace.repl) (clojure.tools.namespace.repl/refresh)<CR>
nmap <Leader>w( ysie)
nmap <Leader>w[ ysie]
nmap <Leader>w{ ysie}
nmap <Leader>w" ysie"
vmap <Leader>w( S)
vmap <Leader>w[ S]
vmap <Leader>w{ S}
vmap <Leader>w" S"

" shift + right/left = slurp/barf
nmap <S-Right> <Plug>(sexp_capture_next_element)<Plug>(sexp_indent)
nmap <S-Left> <Plug>(sexp_emit_tail_element)<Plug>(sexp_indent)
imap <S-Right> <C-O><Plug>(sexp_capture_next_element)<C-O><Plug>(sexp_indent)
imap <S-Left> <C-O><Plug>(sexp_emit_tail_element)<C-O><Plug>(sexp_indent)
nmap <leader>a <Plug>(sexp_raise_list)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! OpenPortal() 
  let result = fireplace#echo_session_eval("(require 'portal.api) (portal.api/tap) (portal.api/open)")
  echo result
endfunction

