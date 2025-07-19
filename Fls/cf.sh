#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
clear
echo -e ""
echo -e "\e[94;1m╔═════════════════════════════════════════════════╗$NC"
echo -e "\033[96;1m                 INPUT SUBDOMAIN \e[0m"
echo -e "\e[94;1m╚═════════════════════════════════════════════════╝ $NC"
echo -e ""
echo -e "\e[91;1m  --[ BENAR ]--\e[0m"
echo -e ""
echo -e "\e[93;1m  • \e[92;1m bodoh , tai , cadux \e[0m"
echo -e ""
echo -e "\e[92;1m  --[ SALAH ]--\e[0m"
echo -e ""
echo -e "\e[93;1m  • \e[91;1m bodoh.my.id , tai.com , cadux.cfd \e[0m"
echo -e " "
echo -e "\e[94;1m╚═════════════════════════════════════════════════╝ $NC"
echo -e " "
echo -e " "
read -p "   INPUT SUBDOMAIN :  " domen
echo -e ""
DOMAIN=hokagelegend.web.id
sub=${domen}
dns=${sub}.hokagelegend.web.id
#(</dev/urandom tr -dc a-z0-9 | head -c5)
#dns=${sub}.hokagelegend.web.id
CF_KEY=ab8d0901acb186291e58f21359d07e7b847dc
CF_ID=faridaumiabi@gmail.com
set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${dns}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${dns}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "$dns" > /root/domain
echo "$dns" > /root/scdomain
echo "$dns" > /etc/xray/domain
echo "$dns" > /etc/v2ray/domain
echo "$dns" > /etc/xray/scdomain
echo "IP=$dns" > /var/lib/kyt/ipvps.conf
cd
