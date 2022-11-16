#!/bin/sh

export SQLCMDSERVER="$SQLSERVER,$SQLPORT"

export CUSTOMER=$(sqlcmd -C -l 1 -W -h -1 -Q "SET NOCOUNT ON; SELECT TOP 1 Name FROM bCompany" 2> /dev/null)
