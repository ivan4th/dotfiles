#home_mqtt_broker_host=192.168.192.3
home_mqtt_broker_host=mqtt.do.sctech.ru

mpub () {
    mosquitto_pub -h "${home_mqtt_broker_host}" -t "$1" -m "$2"
}

# loff () {
#     mpub /devices/thelight/controls/turnOff/on 1
# }

# lon () {
#     mpub /devices/wb-mr11_184/controls/K1/on 1
#     # mpub /devices/thelight/controls/turnOn/on 1
# }

# stemp () {
#     mpub '/devices/heater/controls/setTemp/on' "${1}"
# }

# si_titles=(
#     "SetTemp         = "
#     "Tank->House T   = "
#     "House->Tank T   = "
#     "Tank (middle) T = "
#     "Pressure        = "
#     "Outside T       = "
#     "Dining Room T   = "
#     "Active Power    = "
#     "Power Cost      = "
# )

# si_topics=(
#     '/devices/boiler/controls/targetTemp'
#     '/devices/boiler/controls/temp-tank-to-house'
#     '/devices/boiler/controls/temp-house-to-tank'
#     '/devices/boiler/controls/temp-tank-b'
#     '/devices/boiler/controls/pressure'
#     '/devices/wb-w1/controls/28-0000058e1692'
#     '/devices/wb-w1/controls/28-000007558653'
#     '/devices/milur305_255/controls/Total active power'
#     '/devices/electricity/controls/cost'
# )

# si () {
#     local -a opts=(-h "${home_mqtt_broker_host}" -v)
#     local -a subs=()
#     local sedexp=""
#     for ((i = 0; i < ${#si_titles[@]}; i++)); do
#         subs+=(-t "${si_topics[${i}]}")
#         if [[ ${sedexp} ]]; then
#             sedexp="${sedexp};"
#         fi
#         sedexp="${sedexp}s@${si_topics[${i}]}@${si_titles[${i}]}@"
#     done
#     if [[ ! ${si_continuous:-} ]]; then
#         opts+=(-C "${#si_titles[@]}")
#     fi
#     mosquitto_sub "${opts[@]}" "${subs[@]}" | sed -u "${sedexp}"
# }
    
# siw () {
#     si_continuous=1 si
# }

export HASS_SERVER="http://hass.do.sctech.ru"
export HASS_TOKEN="$(base64 --decode <~/.hass-token)"

hlights () {
  hass-cli entity list | egrep 'light|switch'
}

hat () {
  hass-cli service call homeassistant.toggle --arguments entity_id="${1}" >/dev/null
}

hon () {
  hass-cli service call homeassistant.turn_on --arguments entity_id="${1}" >/dev/null
}

hoff () {
  hass-cli service call homeassistant.turn_off --arguments entity_id="${1}" >/dev/null
}

haout () {
  hat group.outdoor_lights
}

hlist () {
  hass-cli entity list
}

si () {
  # TODO: bathroom (fix sensor)
  hass-cli entity list |
    egrep 'sensor\.(tanka|tankb|tankc|bedroom|lobby|hall|boiler_room|second_floor|valve_x|valve_y|outside|pressure|house|tank|boiler|dining)' |
    sort
}

siw () {
  local out="${HOME}/.siout"
  while true; do
    # avoid flicker
    si >"${out}"
    clear
    cat "${out}"
    sleep 10
  done
}

loff () {
  hoff group.first_floor
  hoff group.second_floor
  hoff group.outdoor_lights
}

l1 () {
  hon light.diningroom
  hon light.bathroom
  hon light.boilerroom
}

l1off () {
  hoff group.first_floor
  hoff group.outdoor_lights
}
