#!/bin/bash
set -e

# starting the server
ag_ctl start
sleep 3

cp /home/agens/Agens_Http/api_server/dbinfo.js.sample /home/agens/Agens_Http/api_server/dbinfo.js
npm start --prefix /home/agens/Agens_Http/api_server

exec "$@"