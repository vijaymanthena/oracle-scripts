#!/bin/bash
# Purge ADR contents (adr_purge.sh)
shortp_days=$1
longp_days=$2
shortp_minutes=$((shortp_days*24*60))
longp_minutes=$((longp_days*24*60))

echo "INFO: adrci purge started at `date`"
adrci exec="show homes"|grep -v : |grep -v "asmcmd\|clients" | while read file_line
do
echo "INFO: adrci purging diagnostic destination " $file_line
echo "INFO: purging ALERT older than $longp_days days"
adrci exec="set homepath $file_line;purge -age $longp_minutes -type ALERT"
echo "INFO: purging INCIDENT older than $longp_days days"
adrci exec="set homepath $file_line;purge -age $longp_minutes -type INCIDENT"
echo "INFO: purging TRACE older than $shortp_days days"
adrci exec="set homepath $file_line;purge -age $shortp_minutes -type TRACE"
echo "INFO: purging CDUMP older than $shortp_days days"
adrci exec="set homepath $file_line;purge -age $shortp_minutes -type CDUMP"
echo "INFO: purging HM older than $shortp_days days"
adrci exec="set homepath $file_line;purge -age $shortp_minutes -type HM"
echo "INFO: purging UTSCDMP older than $shortp_days days"
adrci exec="set homepath $file_line;purge -age $shortp_minutes -type UTSCDMP"
echo ""
echo ""
done
echo
echo "INFO: adrci purge finished at `date`"

