#!/bin/bash

# Отключаем соединение от wifi, при условии, что BSSID не соответствует разрешенному.
# BSSID_CONNECT: вводить только в верхнем регистре BSSID_CONNECT=('12:CE:87:FB:94:08' 'CE:87:FB:94:08')
# SSID_CONNECT: допускается использовать пробелы, но не специальные символы
#
#
# Используйте команду 
# nmcli -f ACTIVE,BSSID,SSID dev wifi
# чтобы узнать BSSID,SSID


BSSID_CONNECT=('11:AA:11:AA:11:A1' '11:AA:11:AA:11:A2' '11:AA:11:AA:11:A3')
SSID_CONNECT=('WIFI_name_1' 'WIFI-name_2' 'WIFI name 3')

interface=$1
status=$2

disconnect_wifi(){
    bssid_ssid_active=$(nmcli -f ACTIVE,BSSID,SSID dev wifi | grep "yes" | awk '{ for(i=2; i<=NF; ++i) printf $i""FS; print "" }' | head -n1)
    bssid_ssid=( $(printf "$bssid_ssid_active") )
    
    if [[ " ${BSSID_CONNECT[*]} " == *"${bssid_ssid[0]}"* && " ${SSID_CONNECT[*]} " == *" ${bssid_ssid[*]:1} "* ]];then
      echo "Подключено" > /dev/null
    else
        nmcli connection down "$CONNECTION_UUID"
    fi
}


if [[ "$interface" =~ ^wlp.* ]] || [[ "$interface" =~ ^wlan.* ]]; then
    if [ "$status" = "up" ]; then
      disconnect_wifi
    fi
fi