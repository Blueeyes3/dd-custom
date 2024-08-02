Container_id=$(docker ps | grep "postgres" | cut -c1-12)
IP_address=$(docker inspect $Container_id | grep -w IPAddress | grep -oP '\d{1,3}(\.\d{1,3}){3}')
echo "$IP_address"
