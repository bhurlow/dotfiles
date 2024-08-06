set fish_greeting

source ~/.config/fish/creds.fish

alias vim nvim
alias k kubectl
alias p pbpaste
alias pprint "bb -e '(clojure.pprint/pprint (clojure.edn/read-string (slurp *in*)))'"
alias prs 'gh pr list -A bhurlow'
alias l 'ls -tr1'

alias grd 'git log --oneline master..develop'
alias ga 'git add'
alias gaa 'git add .'
alias gaaa 'git add -A'
alias gb 'git branch'
alias gbd 'git branch -d '
alias gc 'git commit'
alias gcm 'git commit -m'
alias gco 'git checkout'
alias gcob 'git checkout -b'
alias gcom 'git checkout master'
alias gd 'git diff'
alias gda 'git diff HEAD'
alias gi 'git init'
alias gl 'git log'
alias glg 'git log --graph --oneline --decorate --all'
alias gld 'git log --pretty=format:"%h %ad %s" --date=short --all'
alias gmf 'git merge --no-ff'
alias gp 'git pull'
alias gss 'git status -s'
alias gst 'git stash'
alias gstl 'git stash list'
alias gstp 'git stash pop'
alias gstd 'git stash drop'
alias ga 'git add'
alias gd 'git diff'
alias gs 'git status .'
alias g1 'git log --oneline'
alias cb "git branch | grep '*' | sed 's/\*//g' | cut -d ' ' -f 2"

set -x GOPATH /Users/pretzel/code/gocode
set -x PATH /Users/pretzel/bin $PATH
set -x PATH ~/Library/Python/2.7/bin $PATH
set -x PATH /Users/pretzel/.deno/bin:$PATH
set -x PATH $HOME/.cargo/bin:$PATH
set -x PULUMI_CONFIG_PASSPHRASE_FILE ~/.pulumi/passphrase
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
set -x EDITOR nvim

function source-env
  for i in (cat $argv)
    set arr (echo $i |tr = \n)
    set -gx $arr[1] $arr[2]
  end
end

set fish_prompt_pwd_dir_length 0

# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 242
set __fish_git_prompt_color_dirtystate FCBC47
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_upstream cyan

# Git Characters
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '⇢'
set __fish_git_prompt_char_upstream_prefix ' '
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead '⇡'
set __fish_git_prompt_char_upstream_behind '⇣'
set __fish_git_prompt_char_upstream_diverged '⇡⇣'

function _print_in_color
  set -l string $argv[1]
  set -l color  $argv[2]

  set_color $color
  printf $string
  set_color normal
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo magenta
  else
    echo red
  end
end

eval (/opt/homebrew/bin/brew shellenv)

function fish_prompt
  printf '🐠> '
end

# starship init fish | source

# pnpm
set -gx PNPM_HOME "/Users/pretzel/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
