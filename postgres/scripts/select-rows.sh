#!/bin/bash

#!/bin/sh
DATABASE="postgres"
USERNAME="postgres"
HOSTNAME="postgresql"
export PGPASSWORD="passw0rd"

psql -h $HOSTNAME -U $USERNAME $DATABaSE << EOF
SELECT * FROM orders LIMIT 10;
EOF


