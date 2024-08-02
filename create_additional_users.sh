postgresql_IP=$(./postgresql-fetchIP.sh)
echo "$postgresql_IP"

USERS=$(yq eval '.users' users.yml)
db_host="$postgresql_IP"
db_user="defectdojo"
db_password="defectdojo"
db_name="defectdojo"
for i in $(seq 0 $(($(echo "$USERS" | yq eval 'length') - 1))); do
	id=$(echo "$USERS" | yq eval ".[$i].id" -)
	first_name=$(echo "$USERS" | yq eval ".[$i].first_name" -)
	last_name=$(echo "$USERS" | yq eval ".[$i].last_name" -)
	email=$(echo "$USERS" | yq eval ".[$i].email" -)
	password=$(openssl rand -base64 32)
	query="INSERT INTO auth_user(id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES ('${id}', '${password}', '2024-07-10 01:21:19.539559+00', false, '${first_name} ${last_name}', '${first_name}','${last_name}', '${email}', true, true, '2024-07-10 01:21:19.539559+00');"
	echo "$query"
	PGPASSWORD="${db_password}" psql -h "${db_host}" -U "${db_user}" -d "${db_name}" -c "${query}"
done
