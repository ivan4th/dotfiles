# screen hardcopy / exchange dir
mkdir -p ~/.cache/screen

# serial consoles
alias tu0='screen /dev/ttyUSB0 cs8,115200,ignbrk,-brkint,-icrnl,-imaxbel,-opost,-onlcr,-isig,-icanon,-iexten,-echo,-echoe,-echok,-echoctl,-echoke,noflsh,-ixon,-crtscts'
alias tu1='screen /dev/ttyUSB1 cs8,115200,ignbrk,-brkint,-icrnl,-imaxbel,-opost,-onlcr,-isig,-icanon,-iexten,-echo,-echoe,-echok,-echoctl,-echoke,noflsh,-ixon,-crtscts'

# http://code-and-hacks.peculier.com/articles/setting-terminal-title-in-gnu-screen/
function settitle () {
    if [[ "$TERM" != screen* ]]; then
       return
    fi
    if [ -n "$TMUX" ]; then
        #printf "\033k%s\033\\" "$@"
        printf "\033]2;%s\033\\" "$@"
    elif [ -n "$STY" ]; then
        # We are in a screen session
        # echo "Setting screen titles to $@"
        printf "\033k%s\033\\" "$@"
        # screen -X eval "at \\# title $@" "shelltitle $@"
    else
        printf "\033]0;%s\007" "$@"
    fi
}
