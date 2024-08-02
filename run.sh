chmod 777 dc-build.sh
./dc-build.sh
chmod 777 dc-up-d.sh
./dc-up-d.sh
echo "It takes upto 3 minutes to print the password on the screen, please wait!"
sleep 30s
password=$(docker compose 2>/dev/null logs initializer | grep "Admin password:" | grep -s '\b\w\{22\}\b')
echo -e "\e[41m${password}\e[0m"
