
export CLICOLOR_FORCE=1
export PATH="$PATH:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.npm-global/bin:$HOME/bin:$HOME/.config/yarn/global/node_modules/.bin"
export XDEBUG_CONFIG="idekey=CODE"
export GPG_TTY=$(tty)

# Add an "alert" alias for long running commands.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ~='cd ~'

# Git clear function
function nah() {
    git reset HEAD
    git checkout .
    git clean -fd
}

function fixupme() {
    git commit --fixup $1
    GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash --autostash master
}

if [ "$BASH" ]; then
    alias fuck='sudo $(history -p \!\!)';
fi

if [ "$TERM_PROGRAM" == *"Terminal"* ]; then
  fortune -s -n 100 -e computers | cowsay -f default | lolcat
fi
