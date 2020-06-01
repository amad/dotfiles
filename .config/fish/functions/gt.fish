function gt
    go test $argv | sed ''/PASS/s//(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//(printf "\033[31mFAIL\033[0m")/'' | begin; set -lx GREP_COLOR "01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'; end
end
