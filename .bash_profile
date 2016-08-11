
export CLICOLOR_FORCE=1
export PATH="$PATH:$HOME/.composer/vendor/bin:$HOME/.npm-global/bin:$HOME/bin"

# Add an "alert" alias for long running commands.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ~='cd ~'
# Git clear function
function nah() {
    git reset HEAD
    git checkout .
    git clean -fd
}
