#  Избирательное подключение к Wi-Fi сетям

## Стек: 
* Bash.
  
## Описание:
Скрипт блокирует подключение к нежелательным сетям Wi-Fi через NetworkManager-dispatcher.
Скрипт протестирован и работает на операционной системе Rosa Enterprice Linux Desktop (RELD). 

## Установка и настройка
1. Скопировать файл `wlan_auto_toggle.sh` в каталог `/etc/NetworkManager/dispatcher.d/`.
Установить режим доступа для скрипта:
```bash
sudo chown root:root /etc/NetworkManager/dispatcher.d/wlan_auto_toggle.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/wlan_auto_toggle.sh
```
2. В скрипте `/etc/NetworkManager/dispatcher.d/wlan_auto_toggle.sh` определить обязательные параметры: 
  * `BSSID_CONNECT` - это BSSID Wi-Fi сетей, к которым можно подключаться;
  * `SSID_CONNECT` - это SSID Wi-Fi сетей, к которым можно подключаться.  
Оформление `BSSID_CONNECT`:  
  * только CapsLock; 
  * BSSID указываются через пробел;
  * SSID не должен содержать пробелы и другие спец символы.
```bash
BSSID_CONNECT=('11:AA:11:AA:11:A1' '11:AA:11:AA:11:A2' '11:AA:11:AA:11:A3')
SSID_CONNECT=('WIFI_name_1' 'WIFI-name_2')
```
3. Перезапустить NetworkManager:
```bash
sudo systemctl restart NetworkManager
```
После этого ваш компьютер сможет подключаться только к тем Wi-Fi сетям, BSSID и SSID которых указаны в `BSSID_CONNECT` и `SSID_CONNECT`.
