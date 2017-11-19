source ~/.bash_aliases
alias `~`='cd ~'
set -g -x fish_greeting ''
set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -gx PATH $PATH $HOME/.composer/vendor/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -gx PATH $PATH /usr/local/opt/node@6/bin
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

set -g fish_user_paths "/usr/local/opt/gettext/bin" $fish_user_paths

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]
  fortune -s -n 100 -e computers | cowsay -f default | lolcat
end
