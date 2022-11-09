#!/bin/sh

export SQLSERVER=127.0.0.1
export SQLPORT=11443
export MSSQLTOOLSSERVICE_PATH="$HOME/src/sqltoolsservice/"

export SQLCMDSERVER="$SQLSERVER,$SQLPORT"
export SQLCMDUSER="sa"
export SQLCMDPASSWORD="$CARGAS_PASSWORD"
export SQLCMDDBNAME="CargasEnergy"

export MSSQL_SCRIPTER_CONNECTION_STRING="Data Source=$SQLCMDSERVER;Initial Catalog=$SQLCMDDBNAME;User ID=$SQLCMDUSER;Password=$SQLCMDPASSWORD"

addpath /opt/mssql-tools18/bin/

# export CUSTOMER=$(sqlcmd -l 1 -W -h -1 -Q "SET NOCOUNT ON; SELECT TOP 1 Name FROM bCompany")

# if ! podman exec -it mssqldb id >/dev/null 2>&1 ; then
# #if ! podman ps --format "{{.Names}}" | rg -q "^${MSSQLNAME}$"; then
# 	podman rm -fi "$MSSQLNAME" >/dev/null 2>&1
# 	cuid=$(podman run -it --entrypoint id --rm $MSSQLIMAGE -u | rg -o '\d+')
# 
# 	sqldirs=(
# 		"data"
# 		"log"
# 		"secrets"
# 	)
# 	for sqldir in "${sqldirs[@]}"; do
# 		if [ "$(podman unshare stat --format '%u' $sqldir 2>/dev/null | rg -o '\d+')" != "$cuid" ]; then
# 			mkdir -p "$MSSQLDATA/$sqldir"
# 			podman unshare chown -R "$cuid" "${MSSQLDATA}/${sqldir}"
# 		fi
# 	done
# 	unset sqldirs
# 	unset cuid
# 	podman run --userns=keep-id -e 'ACCEPT_EULA=Y' -e "MSSQL_SA_PASSWORD=$MSSQL_CLI_PASSWORD" -p 1433:1433 -v "$MSSQLDATA/data:/var/opt/mssql/data:Z" -v "$MSSQLDATA/log:/var/opt/mssql/log:Z" -v "$MSSQLDATA/secrets:/var/opt/mssql/secrets:Z" -h "$MSSQLNAME" --name "$MSSQLNAME" -d "$MSSQLIMAGE" >/dev/null
# fi

