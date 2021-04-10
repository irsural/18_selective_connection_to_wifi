#!/bin/bash

#Отключаем соединение от wifi, при условии, что BSSID не соответствует разрешенному.
#BSSID_CONNECT вводить только в верхнем регистре BSSID_CONNECT=('E4:8D:8C:BF:CB:EB' 'E4:8D:8C:BF:CB:F1' 'D8:EB:97:10:8A:86')

BSSID_CONNECT=('12:CE:87:FB:94:08')

interface=$1
status=$2

disconnect_wifi(){
    bssid_active=$(nmcli -f ACTIVE,BSSID dev wifi | grep "yes" | awk '{print$2}'| head -n1)
    
    if [[ " ${BSSID_CONNECT[*]} " != *"$bssid_active"* ]];then
        nmcli connection down "$CONNECTION_UUID"  
    fi
}


if [[ "$interface" =~ ^wlp.* ]] || [[ "$interface" =~ ^wlan.* ]]; then
    if [ "$status" = "up" ]; then
      disconnect_wifi
    fi
fi



