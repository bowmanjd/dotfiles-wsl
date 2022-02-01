#!/bin/sh

MSSQLDATA="$HOME/.mssqldb"

MSSQLIMAGE="mcr.microsoft.com/mssql/server:2019-latest"
MSSQLNAME="mssqldb"

if ! podman ps --format "{{.Names}}" | rg -q "^${MSSQLNAME}$"; then
	podman rm -fi "$MSSQLNAME"
	cuid=$(podman run -it --entrypoint id --rm $MSSQLIMAGE -u | rg -o '\d+')

	sqldirs=(
		"data"
		"log"
		"secrets"
	)
	for sqldir in "${sqldirs[@]}"; do
		if [ "$(podman unshare stat --format '%u' $sqldir 2>/dev/null | rg -o '\d+')" != "$cuid" ]; then
			mkdir -p "$MSSQLDATA/$sqldir"
			podman unshare chown -R "$cuid" "${MSSQLDATA}/${sqldir}"
		fi
	done
	unset sqldirs
	unset cuid
	podman run --userns=keep-id -e 'ACCEPT_EULA=Y' -e "MSSQL_SA_PASSWORD=$MSSQL_CLI_PASSWORD" -p 1433:1433 -v "$MSSQLDATA/data:/var/opt/mssql/data:Z" -v "$MSSQLDATA/log:/var/opt/mssql/log:Z" -v "$MSSQLDATA/secrets:/var/opt/mssql/secrets:Z" -h "$MSSQLNAME" --name "$MSSQLNAME" -d "$MSSQLIMAGE" >/dev/null
fi

