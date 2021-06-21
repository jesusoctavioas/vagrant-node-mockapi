vagrant ssh
cd mockapi
cp db.json sb.json.1
json-server --host 192.168.1.245 db.json
