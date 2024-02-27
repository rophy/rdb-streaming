#!/bin/sh
DATABASE="postgres"
USERNAME="postgres"
HOSTNAME="postgresql"
export PGPASSWORD="passw0rd"

while true
do
    NOTES=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)
    QUANTITY=$((1 + $RANDOM % 10))
    psql -h $HOSTNAME -U $USERNAME $DATABaSE << EOF
INSERT INTO orders (order_date, quantity, notes) values('2023-12-23', ${QUANTITY}, '${NOTES}');
EOF

done

