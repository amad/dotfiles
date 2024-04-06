# Build script to do below

Remove:
- nano

Install:
- g++ gcc clang curl wget build-essential python-software-properties software-properties-common
- vim git git-core gitk
- zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev openvpn
- tmux sysstat htop ack-grep strace unzip
- cowsay fortune
- fish grc
- ngrok fluxgui jcal
- vlc browser-plugin-vlc
- xmonad
- dconf-editor
- synapse
- xfce4-panel
- xfce4-goodies xfce4-pulseaudio-plugin xfce4-volumed xfce4-settings
- xfce4-topmenu-plugin xfce4-screenshooter xfce4-screenshooter-plugin xfce4-power-manager xfce4-power-manager-plugins
- wicd wicd-gtk wicd-cli feh
- python-pip python-dev python-setuptools
- zeal
- fpp
- pip install pywatch lolcat maybe diff-highlight csvkit
- hub
- gpg

junegunn/fzf fuzzy finder
facebook/PathPicker
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
ripgrep

fisher:
fisher add fishpkg/fish-prompt-metro
fisher add fishpkg/fish-humanize-duration
fisher add franciscolourenco/done
fisher add laughedelic/pisces
fisher add jethrokuan/fzf


set --universal hydro_color_git cyan
set branch (
    fish_git_prompt ' ' | tr -d '[:space:]'
)
