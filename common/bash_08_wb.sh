mpub () {
    mosquitto_pub -h 192.168.20.36 -t "$1" -m "$2"
}

loff () {
    mpub /devices/thelight/controls/turnOff/on 1
}

lon () {
    mpub /devices/wb-mr11_184/controls/K1/on 1
    # mpub /devices/thelight/controls/turnOn/on 1
}

