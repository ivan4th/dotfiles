# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If running interactively, then:
if [ "$PS1" ]; then

    # don't put duplicate lines in the history. See bash(1) for more options
    # export HISTCONTROL=ignoredups

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    #shopt -s checkwinsize

    shopt -s histappend

    # enable color support of ls and also add handy aliases
    if [ "$TERM" != "dumb" ]; then
	eval `dircolors -b`
	alias ls='ls --color=auto'
	#alias dir='ls --color=auto --format=vertical'
	#alias vdir='ls --color=auto --format=long'
    fi

    # some more ls aliases
    #alias ll='ls -l'
    #alias la='ls -A'
    #alias l='ls -CF'

    # set a fancy prompt
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

    export HISTSIZE=1000000
    export HISTFILESIZE=1000000
    export HISTFILE="$HOME/.shell_history"

    # If this is an xterm set the title to user@host:dir
    case $TERM in
    xterm*)
        PROMPT_COMMAND='history -a;_prm_subtitle=;if [ -n "$subtitle" ]; then _prm_subtitle="$subtitle : "; fi; echo -ne "\033]0;$_prm_subtitle${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    screen)
        PROMPT_COMMAND='history -a;echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
        #PROMPT_COMMAND='history -a;_prm_subtitle=;if [ -n "$subtitle" ]; then _prm_subtitle="$subtitle : "; fi; echo -ne "\033_$_prm_subtitle${USER}@${HOSTNAME}: ${PWD}\033\\"'
        ;;
    *)
	PROMPT_COMMAND='history -a'
        ;;
    esac

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi

source /etc/profile
source "$HOME/.myrc"
