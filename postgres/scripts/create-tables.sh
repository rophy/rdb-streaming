#!/bin/bash

DATABASE="postgres"
USERNAME="postgres"
HOSTNAME="postgresql"
export PGPASSWORD="passw0rd"

psql -h $HOSTNAME -U $USERNAME $DATABaSE << EOF
DROP TABLE IF EXISTS orders;

CREATE TABLE orders ( 
  order_id integer primary key generated by default as identity,
  order_date date,
  quantity integer,
  notes varchar(200),
  created timestamp default current_timestamp
);
EOF


