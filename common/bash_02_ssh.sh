# http://code-and-hacks.peculier.com/articles/setting-terminal-title-in-gnu-screen/
function settitle () {
    if [ "$TERM" != "screen" ]; then
       return
    fi
    if [ -n "$STY" ] ; then
        # We are in a screen session
        # echo "Setting screen titles to $@"
        printf "\033k%s\033\\" "$@"
        # screen -X eval "at \\# title $@" "shelltitle $@"
    else
        printf "\033]0;%s\007" "$@"
    fi
}

# rebuild ssh config
ussh () {
    (echo "# GENERATED FILE!!!!! DO NOT EDIT!!!!!"; cat ~/.ssh/config.d/*) >~/.ssh/config
}

ussh

grep '^ *Host .*#CMD' ~/.ssh/config |
    sed 's/^Host *\| *#.*//g' |
    while read h; do
        echo "alias $h='settitle $h; ssh $h'"
    done >~/.ssh/aliases
. ~/.ssh/aliases

# from http://tychoish.com/rhizome/9-awesome-ssh-tricks/
sshreagent () {
     for agent in /tmp/ssh-*/agent.*; do
         export SSH_AUTH_SOCK=$agent
         if ssh-add -l 2>&1 > /dev/null; then
             echo Found working SSH Agent:
             ssh-add -l
             return
         fi
    done
    echo Cannot find ssh agent - maybe you should reconnect and forward it?
}
