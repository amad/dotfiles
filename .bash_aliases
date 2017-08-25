# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias desktop='cd ~/Desktop'
alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'
alias code='cd ~/Code'

# Shortcuts
alias compress='tar -zcvf'
alias extract='tar -zxvf'
alias install='sudo apt install'
alias v='vim'
alias s='sudo'
alias px='ps aux'
alias fn='find -name'
alias p='ping 8.8.8.8'
alias fs='stat -f "%z bytes"'
alias fn='find ./ -name'
alias myip='curl ip.appspot.com'
alias mysqlc='mysql -u root -p'
alias mysqldumpc='mysqldump -u root -p'

# Defaults
alias rm='rm -v'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# GIT
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit -m'
alias gs='git status -s'
alias gp='git push origin master'
alias master='git checkout master'
alias dev='git checkout dev'
alias back='git checkout -'
alias checkout='git checkout'
alias branch='git branch'
alias new='git checkout -b'
alias commit='git commit'
alias clone='git clone'
alias fetch='git fetch -p'
alias fetchall='git fetch -all'
alias pull='git pull --rebase --prune --verbose --no-ff --no-commit --no-stat --autostash'
alias pullme='git fetch -p upstream; git pull --rebase --prune --verbose --no-ff --no-commit --no-stat --autostash upstream master'
alias push='git push origin HEAD'
alias forcepush='git push --force-with-lease origin HEAD'
alias undopush='git push -f origin HEAD^:master'
alias stash='git stash -k -u'
alias stashall='git stash --include-untracked'
alias pop='git stash pop'
alias undo='git reset --soft HEAD^'
alias unstage='git reset HEAD'
alias unstageall='git reset HEAD .'
alias amend='git commit --amend --no-edit'
alias standup='git --no-pager log --all --no-merges --oneline --date="relative" --since="yesterday"'
alias mystandup='standup --author=(git config user.name)'
alias glp='git log -p'
alias log='git log -p'
alias gl='git log --graph --abbrev-commit --pretty=oneline -n 20'
alias rmbranch='git branch -D'
alias rmibranch='git push origin :'
alias merged='git branch --merged | grep -v "\*"'
alias allmerged='git branch --merged -r | grep -v "\*"'
alias notmerged='git branch --no-merged'
alias show-ref='git show-ref'
alias show='git show'
alias news='git log ..master'
alias fixup='git commit --fixup'
alias rebaseme='git rebase master --autostash'
alias rebase='git rebase -i master --autostash'
alias autorebase='git rebase -i --autosquash --autostash'
alias merge='git merge'
alias mergenoff='git merge --no-ff'
alias copy='fpp -c "echo \$F | pbcopy"'
alias edit='fpp -c subl'
alias hmm='subl ./'
alias repo="open https://github.(git config remote.origin.url | cut -f2 -d. | tr ':' /)"

# PHP
alias ptree='tree -d -L 10 -I "vendor|tests|test|node_modules" --matchdirs'
alias pdoc='/usr/bin/phpdoc -d ./ -t ./docs -i "docs/*,vendor/*"'
alias phpxdebug='php -dxdebug.remote_enable=1 -dxdebug.remote_mode=req -dxdebug.remote_port=9000 -dxdebug.remote_host=127.0.0.1 -dxdebug.remote_connect_back=0'
