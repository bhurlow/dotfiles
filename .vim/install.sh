#! /bin/bash

mkdir ~/.vim/bundle
pushd ~/.vim/bundle

packages=(
 ctrlpvim/ctrlp.vim
 easymotion/vim-easymotion
 ervandew/supertab
 guns/vim-clojure-static
 dag/vim-fish
 tpope/vim-repeat
 tpope/vim-surround
 mattn/emmet-vim
 godlygeek/tabular
 tpope/vim-commentary
 tpope/vim-fireplace
 bhurlow/vim-parinfer
 tpope/vim-unimpaired
 tpope/vim-speeddating
 fatih/vim-go
 pangloss/vim-javascript
 prettier/vim-prettier
 w0rp/ale
 mxw/vim-jsx
 ElmCast/elm-vim
 neoclide/coc.nvim
 guns/vim-sexp.git
 tpope/vim-sexp-mappings-for-regular-people.git
)

for x in "${packages[@]}"
do
  echo $var
  git clone https://github.com/$x
done
