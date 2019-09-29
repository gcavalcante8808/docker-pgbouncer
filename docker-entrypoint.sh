#!/bin/bash

set -e

if [[ -z ${DB_HOST+x} ]]; then
    echo "No Default DB Host Provided. Quiting ..."
    exit 1
fi

if [[ -z ${DB_NAME+x} ]]; then
    echo "No Default DB NAME Provided. Quiting ..."
    exit 1
fi

if [[ -z ${DB_USER+x} ]]; then
    echo "No Default DB User Provided. Assuming Postgres"
    DB_USER="postgres"
fi

if [[ -z ${DB_PASSWORD+x} ]]; then
    echo "No Default DB Password Provided. Assuming 'postgres'"
    DB_PASSWORD="postgres"
fi

if [[ -z ${DB_PORT+x} ]]; then
   echo "No default Port Provided, using 5432 as default"
fi

if [[ -z ${MAX_CLIENT_CONN+x} ]]; then
    echo "No Max client Conn Provided. Assuming 100 connections in session mode."
    MAX_CLIENT_CONN=100
fi

echo "Writing pgbouncer.ini file"
cat <<EOT > /etc/pgbouncer/pgbouncer.ini

[databases]
${DB_NAME} = host=${DB_HOST} port=${DB_PORT:-5432} dbname=${DB_NAME} ${CONNECTION_OPTIONS}

[pgbouncer]
#logfile = /var/log/pgbouncer.log
#pidfile = /var/run/pgbouncer/pgbouncer.pid

listen_addr = *
listen_port = 5432

auth_type = plain
auth_file = /etc/pgbouncer/userlist.txt

server_tls_sslmode = allow

pool_mode = session
max_client_conn = ${MAX_CLIENT_CONN}
default_pool_size = ${MAX_CLIENT_CONN}

EOT

if [[ ! -z ${IGNORE_STARTUP_OPTIONS} ]]; then
    echo "ignore_startup_parameters = ${IGNORE_STARTUP_OPTIONS}" >> /etc/pgbouncer/pgbouncer.ini
fi

echo "Writing auth file for pgbouncer"

cat <<EOT > /etc/pgbouncer/userlist.txt
"${DB_USER}" "${DB_PASSWORD}"
EOT

exec pgbouncer /etc/pgbouncer/pgbouncer.ini
