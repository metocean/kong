echo "CREATE USER kong; CREATE DATABASE kong OWNER kong; ALTER USER kong WITH PASSWORD 'secret'; CREATE USER konga; CREATE DATABASE konga OWNER konga; ALTER USER konga WITH PASSWORD 'secret';" | psql -U postgres --password -d postgres -h 127.0.0.1