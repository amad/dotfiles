function rigfor
    if test (count $argv) -gt 0
        set -e AWS_ACCESS_KEY_ID
        set -e AWS_SECRET_ACCESS_KEY
        set -e AWS_DEFAULT_REGION
        set -e AWS_ACCESS_KEY_ID
        set -e AWS_SECRET_ACCESS_KEY
        set -e AWS_SESSION_TOKEN

        /Users/ahmadsamiei/rigfor.sh $argv[1]
        source /Users/ahmadsamiei/.awsenv
    else
        set -e AWS_ACCESS_KEY_ID
        set -e AWS_SECRET_ACCESS_KEY
        set -e AWS_DEFAULT_REGION
        set -e AWS_ACCESS_KEY_ID
        set -e AWS_SECRET_ACCESS_KEY
        set -e AWS_SESSION_TOKEN

        source /Users/ahmadsamiei/.awsenv
    end
end
