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

alias unssh="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
