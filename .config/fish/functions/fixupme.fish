function fixupme
    git commit --fixup $argv
    env GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash --autostash origin/master
end
