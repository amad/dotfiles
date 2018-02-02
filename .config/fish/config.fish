source ~/.bash_aliases
alias `~`='cd ~'
set -gx fish_greeting ''
set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -gx PATH $PATH $HOME/.composer/vendor/bin
set -gx PATH $PATH /usr/local/opt/node@6/bin
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin
set -gx fish_user_paths "/usr/local/opt/gettext/bin" $fish_user_paths
set -gx PATH $PATH $HOME/Go/bin
set -gx PATH $PATH /usr/local/opt/go/libexec/bin
set -gx XDEBUG_CONFIG 'idekey=CODE'
set -gx GOPATH $HOME/Go
set -gx GOROOT /usr/local/opt/go/libexec
set -gx GPG_TTY (tty)

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]
  fortune -s -n 100 -e computers | cowsay -f default | lolcat
end
