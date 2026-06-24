set fish_greeting

function fish_title
    if set -q argv[1]
        echo -- (string sub -l 20 -- $argv[1]) (prompt_pwd -d0)

    else
        set -l command (status current-command)

        if [ $command = fish ]
            set command
        end

        echo -- (string sub -l 20 -- $command) (prompt_pwd -d0)
    end
end
