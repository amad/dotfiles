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
set -gx PATH $PATH /Users/ahmadsamiei/Library/Python/3.7/bin
set -gx PATH $PATH /Users/ahmadsamiei/Library/Python/2.7/bin
set -gx PATH $PATH $HOME/.pyenv/bin
set -gx PYENV_ROOT $HOME/.pyenv
set -gx XDEBUG_CONFIG 'idekey=CODE'
set -gx GOPATH $HOME/Go
set -gx GOROOT /usr/local/opt/go/libexec
set -gx GPG_TTY (tty)
set -gx AWS_PROFILE poc
set -gx AWS_REGION eu-west-1
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
set -x PATH $HOME/.fastlane/bin $PATH

set -gx PYTHONPATH /Library/Python/2.7/site-packages

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]
  fortune -s -n 100 -e computers | cowsay -f default | lolcat
end

touch /Users/ahmadsamiei/.hushlogin
set -g fish_user_paths "/usr/local/opt/node@10/bin" $fish_user_paths

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/sls.fish ]; and . /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/slss.fish ]; and . /Users/ahmadsamiei/Code/delme/node_modules/tabtab/.completions/slss.fish
set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@12/bin" $fish_user_paths
