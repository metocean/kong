#Development environment for Kong plugins

## Start Postgres
1. docker-compose up postgres
2. init_db.sh (if not already initialised)
3. docker-compose up

## Start pgadmin
1. Login as pgadmin@pgadmin.org:admin
2. Create connection to host postgres as user postgres:secret

## (Re)Start gateway
export PATH="$PATH:/usr/local/openresty/bin"
./bin/kong restart -c dev_env/kong.conf

## Konga
1. Set connection to http://<your_machine_IP>

As long as you don't remove /tmp/postgres (or contents) state should be persistent
