source ~/.bash_aliases
alias `~`='cd ~'
fortune | cowsay -f elephant | lolcat
set -g -x fish_greeting ''
set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -gx PATH $PATH $HOME/.composer/vendor/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -gx PATH $PATH /usr/local/opt/node@6/bin
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

set -g fish_user_paths "/usr/local/opt/gettext/bin" $fish_user_paths
