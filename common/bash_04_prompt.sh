export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export PS1='\[\033[1;95m\]${debian_chroot:+($debian_chroot)}\u@\h\[\e[0m\]:\[\e[1;32m\]\w\[\033[0;33m\]$(__git_ps1 " (%s) ")\[\e[0m\]\$ '
