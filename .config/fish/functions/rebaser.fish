function rebaser
    git checkout develop
    git fetch -p origin; git pull --rebase --prune --verbose --no-ff --no-commit --no-stat --autostash origin develop
    git checkout $argv
    git rebase develop --autostash
    git push --force-with-lease origin HEAD
end
