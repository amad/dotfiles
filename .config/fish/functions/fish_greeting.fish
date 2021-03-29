function fish_greeting
    if not which fortune > /dev/null ^ /dev/null
        switch (uname)
            case Darwin
                echo Installing fortune and cowsay
                brew install fortune
                sudo gem install lolcat
            case Linux
                echo Installing fortune and cowsay
                if which apt-get > /dev/null ^ /dev/null
                    sudo apt-get install fortune cowsay
                else
                    sudo yum install fortune cowsay
                end
            case '*'
                echo Wait ... where are we\? (uname), eh
        end
    end

    set -l toon (random choice {default,bud-frogs,dragon,dragon-and-cow,elephant,moose,stegosaurus,tux,vader})
    if which lolcat > /dev/null ^ /dev/null
        fortune -s -n 100 -e computers | cowsay -f default | lolcat
    else if which fortune > /dev/null ^ /dev/null
        fortune -s -n 100 -e computers | cowsay -f default
    else
        echo Something fishy going on around here ...
    end
end
