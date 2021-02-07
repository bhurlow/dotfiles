
" GENERAL

set nocompatible
execute pathogen#infect()
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set nu
filetype plugin on
filetype plugin indent on
let mapleader = ","
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest

" set visualbell

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
set relativenumber

" supertab

" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
" let g:SuperTabClosePreviewOnPopupClose = 1

" autocmd FileType *
"       \if &omnifunc != '' |
"       \call SuperTabChain(&omnifunc, "<c-p>") |
"       \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
"       \endif



" set cursorline
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set number
set nowrap
set textwidth=79
set formatoptions=qrn1
set pastetoggle=<leader>p
set cmdwinheight=20

function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction

function! RemoteEval()

  let [win, line, col, offset] = getpos('.')
  let path = expand('%:p') 

  let payload = { "version": 1 }
  let payload.line = line
  let payload.col = col
  let payload.path = path

  let strData = json_encode(payload)
  let cmdS = join(['echo', "'", strData, "'", '|', 'nc localhost 8080'], ' ')

  let res = system(cmdS)

  echo res

endfunction

function! ExecuteInShell(command) 
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction 
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

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

nnoremap <leader>m :! clear && DEBUG='yd:*' mocha --timeout 10000 --bail --require @babel/register --require test/testhelper.js %:p <cr>

nnoremap <leader>e :! clear && LOG_LEVEL=60 yarn --silent babel-node %:p <cr>

nnoremap <leader>bb :! clear && bb %:p <cr>

nnoremap <leader>c :%! zprint <cr>

set mouse=""

au BufRead,BufNewFile *.edn set syntax=clojure
au BufRead,BufNewFile Dockerfile set filetype=conf

set noswapfile
set undodir=/tmp/.vimundo

" SYNTAX

set background=light
syntax enable
syntax on
set guifont=Inconsolata:h15

hi clear CursorLine
hi Normal guibg=#242932 guifg = #eff0ea
hi Conditional ctermfg = green
hi LineNr ctermfg = grey guibg=#242932 guifg=#686767
hi MatchParen ctermbg=none cterm=underline ctermfg=magenta
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

" some nicer ale styles
hi SignColumn ctermbg=none
hi ALEErrorSign ctermfg=red

hi Comment ctermfg = 240
hi String ctermfg = yellow
hi jsTemplateString ctermfg = blue
hi Type ctermfg = blue guifg=#88c0d0


hi Comment guifg=grey
hi SignColumn guibg=grey guifg=grey



" KEY MAPPING

nnoremap ; :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>ft Vatzf
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>w <C-w>v<C-w><leader>t
nnoremap q :call feedkeys("gqaf")<CR>

nmap <leader>gd <Plug>(coc-definition)

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap % v% 
noremap <leader>r :Require<CR>
map - :Explore<CR>


" EMMET VIM
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

autocmd FileType html,php,scss,css,javascript EmmetInstall

" autocmd FileType haskell setlocal commentstring=###\ %s

" because fish isn't bash compatible
if &shell =~# 'fish$'
  set shell=sh
endif

set wildignore+=*/tmp/*,*/out/*,*/target/*,*.so,*.swp,*.zip

let g:ctrlp_working_path_mode = 'cra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|out)$'

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


" let g:sexp_mappings = {}
" nmap <buffer> B <Plug>(sexp_move_to_prev_element_head)

" autocmd FileType clojure
"   autocmd!
"   nmap <buffer> M <Plug>(sexp_insert_at_list_head)
" augroup END

function! g:FormatClojure()
  let [win, line, col, offset] = getpos('.')
  execute ":%!parindent --stdin"
  call cursor(line, col)
endfunction

augroup filetype_clojure
  autocmd!
  " autocmd FileType clojure setlocal foldmethod=indent
  " autocmd FileType clojure nnoremap fa zM<cr>
  " autocmd FileType clojure nnoremap ee zR<cr>
  " map <leader>p :%!parindent --stdin <cr>
  autocmd FileType clojure nnoremap <buffer> <silent> <leader>p :call FormatClojure() <cr>
  map <leader>M ((<Plug>(sexp_insert_at_list_tail)<cr>
  map <leader>n $<cr>i
  " nmap )) dd<cr>
  " nnoremap M dd<cr>
augroup END

" let g:sexp_mappings = {
"  \ 'sexp_inner_list': 'M',
"  \ 'sexp_move_to_prev_bracket':      '<Leader>m',
"  \ }

" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" use tabs over spaces
let g:prettier#config#use_tabs = 'false'

" print semicolons
let g:prettier#config#semi = 'false'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'

" none|es5|all
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = 'flow'


let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]


let g:javascript_plugin_flow = 1
let g:ale_linters_explicit = 1

" let b:ale_linters = ['eslint']

" let g:ale_linters = {'clojure': ['clj-kondo']}

" let g:ale_enabled = 0
" map <leader>a :ALEToggle<CR>

let g:CommandTFileScanner = "git"

let g:rainbow_active = 1


nmap <leader>f <Plug>(coc-format-selected)

nmap <leader>g <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>u <Plug>(coc-references)

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

" https://github.com/snoe/dotfiles/blob/master/home/.vimrc
nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>



