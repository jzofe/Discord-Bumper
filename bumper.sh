#!/bin/bash

config_dosyasi=".bumper_config"

if [ ! -f "$config_dosyasi" ] || [ ! -s "$config_dosyasi" ]; then
    read -p "Authorization tokeni girin: " authorization
    echo "$authorization" > $config_dosyasi
    echo "Authorization: ${authorization:0:6}******"
    echo "Yapılandırma dosyası oluşturuldu: $config_dosyasi"
fi

user_agent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.107 Safari/537.36"

authorization=$(sed -n '1p' $config_dosyasi)

if [ -z "$authorization" ]; then
    read -p "Authorization tokeni boş. Lütfen bir Authorization tokeni girin: " authorization
    echo "$authorization" > $config_dosyasi
fi

clear
echo "Auth algılandı. Giriş başarılı."
echo ""
echo "Bumper v0.1 Coded by Fyks <jzofe>"
echo ""
echo "Komutlar : 'bumper'" 

bumper_shell() {
    read -p "bumper > " komut

    case "$komut" in
        "bumper")
            echo ""
            echo "Bumper Komutları :"
            echo "kanal       : Kanalın ID değerini girin"
            echo "nonce       : Mesajın ID değerini girin"
            echo "user-agent  : User-Agent değiştir      "
            echo "boom        : Apiyi kandırın "
            echo "sil         : Ekranı temizle "
            echo "çık         : Bumper scriptini kapat"
            echo "typinghack  : Yazıyormuş gibi gözükürsünüz. "
            echo ""
            echo "discord     : Ender Topluluk Discord adresi"
            echo ""
            bumper_shell
            ;;
        "kanal")
            read -p "Kanal ID: " kanal
            bumper_shell
            ;;
        "typinghack")
            read -p "Sunucu ID: " sunucu
            read -p "Kanal ID: " kanal2
            echo "Çalıştırmak için 'typing'"
            bumper_shell
            ;;
        "typing")
            typinghacks
            ;;
        "nonce")
            read -p "Nonce değeri: " nonce
            bumper_shell
            ;;
        "sil")
            clear
            bumper_shell
            ;;
        "çık")
            exit 0
            ;;
        "discord")
            echo -e "\033[0;31mdiscord.gg/W6eJSY2k\033[0m"
            ;;
        "user-agent")
            read -p "User-Agent girin: " user_agent
            bumper_shell
            ;;
        "boom")
            read -p "İçerik (content) değeri: " content
            calistir
            ;;
        *)
            echo "Geçersiz komut. Komutlar için 'bumper'"
            bumper_shell
            ;;
    esac
}

typinghacks() {

    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
      https://discord.com/api/v9/channels/$kanal2/typing \
      -H "User-Agent: $user_agent" \
      -H "Accept: */*" \
      -H "Accept-Language: tr-TR,tr;q=0.8,en-US;q=0.5,en;q=0.3" \
      -H "Authorization: $authorization" \
      -H "X-Super-Properties: eyJvcyI6IldpbmRvd3MiLCJicm93c2VyIjoiRmlyZWZveCIsImRldmljZSI6IiIsInN5c3RlbV9sb2NhbGUiOiJ0ci1UUiIsImJyb3dzZXJfdXNlcl9hZ2VudCI6Ik1vemlsbGEvNS4wKChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2OjEyMy4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzEyMy4wIiwiYnJvd3Nlcl92ZXJzaW9uIjoiMTIzLjAiLCJvc192ZXJzaW9uIjoiMTAiLCJyZWZlcnJlciI6IiIsInJlZmVycmluZ19kb21haW4iOiIiLCJyZWZlcnJlcl9jdXJyZW50IjoiIiwicmVmZXJyaW5nX2RvbWFpbl9jdXJyZW50IjoiIiwicmVsZWFzZV9jaGFubmVsIjoic3RhYmxlIiwiY2xpZW50X2J1aWxkX251bWJlciI6MjY4NjAwLCJjbGllbnRfZXZlbnRfc291cmNlIjpudWxsfQ==" \
      -H "X-Discord-Locale: en" \
      -H "X-Discord-Timezone: Europe/Istanbul" \
      -H "X-Debug-Options: bugReporterEnabled" \
      -H "Sec-GPC: 1" \
      -H "Sec-Fetch-Dest: empty" \
      -H "Sec-Fetch-Mode: cors" \
      -H "Sec-Fetch-Site: same-origin" \
      --referer "https://discord.com/channels/$sunucu/$kanal2")

    if [ $response -ge 200 ] && [ $response -le 500 ]; then
      echo ""
      echo -e "[\033[0;32m$response\033[0m] >> Typing Apisi kandırıldı."
    else
      echo -e "\033[0;31m[-] Typing gönderirken bir hata oluştu. Durumu kontrol edin.\033[0m"
    fi

   

    bumper_shell 
}

calistir() {

    json_data=$(cat <<EOF
{
  "mobile_network_type": "unknown",
  "content": "$content",
  "nonce": "$nonce",
  "tts": false,
  "flags": 0
}
EOF
)


    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
      https://discord.com/api/v9/channels/$kanal/messages \
      -H "User-Agent: $user_agent" \
      -H "Accept: */*" \
      -H "Accept-Language: tr-TR,tr;q=0.8,en-US;q=0.5,en;q=0.3" \
      -H "Content-Type: application/json" \
      -H "Authorization: $authorization" \
      -H "X-Super-Properties: eyJvcyI6IldpbmRvd3MiLCJicm93c2VyIjoiRmlyZWZveCIsImRldmljZSI6IiIsInN5c3RlbV9sb2NhbGUiOiJ0ci1UUiIsImJyb3dzZXJfdXNlcl9hZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2OjEyMy4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzEyMy4wIiwiYnJvd3Nlcl92ZXJzaW9uIjoiMTIzLjAiLCJvc192ZXJzaW9uIjoiMTAiLCJyZWZlcnJlciI6IiIsInJlZmVycmluZ19kb21haW4iOiIiLCJyZWZlcnJlcl9jdXJyZW50IjoiIiwicmVmZXJyaW5nX2RvbWFpbl9jdXJyZW50IjoiIiwicmVsZWFzZV9jaGFubmVsIjoic3RhYmxlIiwiY2xpZW50X2J1aWxkX251bWJlciI6MjY4NjAwLCJjbGllbnRfZXZlbnRfc291cmNlIjpudWxsfQ==" \
      -H "X-Discord-Locale: en" \
      -H "X-Discord-Timezone: Europe/Istanbul" \
      -H "X-Debug-Options: bugReporterEnabled" \
      -H "Sec-GPC: 1" \
      -H "Sec-Fetch-Dest: empty" \
      -H "Sec-Fetch-Mode: cors" \
      -H "Sec-Fetch-Site: same-origin" \
      -d "$json_data")
     

    if [ $response -ge 200 ] && [ $response -le 500 ]; then
      echo ""
      echo -e "[\033[0;32m$response\033[0m] >> Api kandırıldı. Başarılı request!"
    else
      echo ""
      echo -e "\033[0;31m[-] Hatalı request. Fetch'in doğru olduğundan emin olun.\033[0m]"
    fi


    bumper_shell
}


bumper_shell
