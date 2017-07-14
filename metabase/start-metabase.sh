#!/bin/sh
export MB_JETTY_HOST=0.0.0.0
export MB_DB_TYPE=postgres
export MB_DB_DBNAME=metabase
export MB_DB_PORT=5432
export MB_DB_USER=metabase
export MB_DB_PASS=metabase
export MB_DB_HOST=localhost

cd /usr/local/bin/metabase/
nohup java -jar metabase.jar </dev/null >/dev/null 2>&1 &

exit 0
