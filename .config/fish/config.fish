if status is-interactive
    source ~/.bash_aliases
    alias `~`='cd ~'
    touch /Users/ahmadsamiei/.hushlogin
end

set -gx PATH $PATH $HOME/bin
set -g fish_user_paths "/Users/ahmadsamiei/Library/Python/3.9/bin" $fish_user_paths
set -gx GPG_TTY (tty)

set -gx DOTFILES /Users/ahmadsamiei/projects/dotfiles

#if [ "$TERM_PROGRAM" = "Apple_Terminal" ]
#  fortune -s -n 100 -e computers | cowsay -f default | lolcat
#end

set -gx VAULT_ADDR https://vault.pusherplatform.io:8200
