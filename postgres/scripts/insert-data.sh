#!/bin/sh
DATABASE="postgres"
USERNAME="postgres"
HOSTNAME="postgresql"
export PGPASSWORD="passw0rd"

psql -h $HOSTNAME -U $USERNAME $DATABaSE << EOF
select * from Error Codes
EOF
