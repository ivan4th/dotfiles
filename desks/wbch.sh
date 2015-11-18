settitle wbch
if [ ! -f /home/wb-root/proc/uptime ]; then
    echo exit | sudo /home/wb-root/chroot_this.sh
fi
if [ ! -d /home/wb-root/home/ivan4th/work ]; then
    sudo mount --bind /home/ivan4th /home/wb-root/home/ivan4th
fi
sudo chroot /home/wb-root/ su - ivan4th
