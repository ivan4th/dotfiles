# screen hardcopy / exchange dir
mkdir -p ~/.cache/screen

# serial consoles
alias tu0='screen /dev/ttyUSB0 cs8,115200,ignbrk,-brkint,-icrnl,-imaxbel,-opost,-onlcr,-isig,-icanon,-iexten,-echo,-echoe,-echok,-echoctl,-echoke,noflsh,-ixon,-crtscts'
alias tu1='screen /dev/ttyUSB1 cs8,115200,ignbrk,-brkint,-icrnl,-imaxbel,-opost,-onlcr,-isig,-icanon,-iexten,-echo,-echoe,-echok,-echoctl,-echoke,noflsh,-ixon,-crtscts'
