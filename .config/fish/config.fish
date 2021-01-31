
# disable fish greeting
set fish_greeting

source ~/.config/fish/creds.fish

alias tmux 'env TERM=screen-256color-bce tmux'
alias p pbpaste

alias pprint "bb -e '(clojure.pprint/pprint (clojure.edn/read-string (slurp *in*)))'"

set -x GOPATH /Users/pretzel/code/gocode
set -x PATH /Users/pretzel/bin $PATH
set -x PATH /Users/pretzel/code/cljtool $PATH
set -x PATH ~/Library/Python/2.7/bin $PATH
set -x PATH /Users/pretzel/.deno/bin:$PATH
set -x PATH $HOME/.cargo/bin:$PATH

# set -x PATH /Users/pretzel/code/graalvm-1.0.0-rc1/Contents/Home/bin $PATH
# set -x JAVA_HOME /Users/pretzel/code/graalvm-1.0.0-rc1/Contents/Home
# set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home
# set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
# set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_161.jdk/Contents/Home
# set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-15.0.1.jdk/Contents/Home

set -x EDITOR vim

alias l 'ls -tr1'

alias ls 'exa'

function mysql-shell
  echo $DB_HOST >&2
  mysql --silent -h $DB_HOST  -u $DB_USER --password=$DB_PASS $DB_NAME
end

function mysql-exec 
  echo $DB_HOST >&2
  mysql -N --silent -h $DB_HOST  -u $DB_USER --password=$DB_PASS $DB_NAME -e $argv
end

function source-env
	for i in (cat $argv)
		set arr (echo $i |tr = \n)
  		set -gx $arr[1] $arr[2]
	end
end

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

function de 
  docker exec -it $argv /bin/bash
end

function dps
  docker ps --format '{{.ID}} {{ .Image }}'
end

function fish_prompt
  set DIR (basename $PWD)
  echo -n (pwd) '🥨 > '
end
