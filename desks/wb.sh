if [ "$HOSTTYPE" != "arm" ]; then
    # don't change title after chroot
    settitle wbdev
fi
cd ~/work/contactless
alias ch="settitle wbch; /usr/bin/proot -R /home/wb-root -q qemu-arm -b /home/ivan4th:/home/ivan4th /bin/bash"
alias chr="settitle wbchr; sudo /usr/bin/proot -R /home/wb-root -q qemu-arm -b /home/ivan4th:/home/ivan4th /bin/bash"
