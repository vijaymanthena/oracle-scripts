#!/bin/bash
#################################################################################
#                                                                               #
# Script - adrci_setup_purge.sh                                                 #
#                                                                               #
# Usage - adrci_setup_purge.sh <short_purge_hours> <long_purge_hours>           #
#                                                                               #
# Parameters -                                                                  #
#  1) retention time in hours for shortp_policy trace files                     #
#        The SHORTP_POLICY (Default value - 720 hours / 30 days) applies to:    #
#               Trace files, including files stored in the cdmp_timestamp       #
#               Core dump files                                                 #
#               Packaging information                                           #
#  2) Retention time in hours for longp_policy trace files                      #
#       The LONGP_POLICY (Default value - 8760 hours (365 days)) applies to:    #
#               Incident information                                            #
#               Incident dumps                                                  #
#               Alert logs                                                      #
#                                                                               #
# Examples:                                                                     #
#     For non-prod - adrci_setup_purge.sh 192 744                               #
#       Sets purge policy for non-prod servers to 8 days for short term         #
#                                            and 31 days for long term          #
#         For Production - adrci_setup_purge.sh 360 2184                        #
#       Sets purge policy for prod servers to 15 days for short term            #
#                                         and 91 days for long term             #
#                                                                               #
# Author:                                                                       #
#     manthenav     2021/10/17    Initial commit                                #
#                                                                               #
#################################################################################

echo "INFO: adrci setup started at `date`"
short_hours=$1
long_hours=$2
adrci exec="show homes"|grep -v : |grep -v "user_root" | while read file_line
do
echo "INFO: adrci Setting Short Purge Policy " $file_line
echo "INFO: Setting ADR Short purge policy to ${short_hours} hours "
adrci exec="set homepath ${file_line};set control \(SHORTP_POLICY=${short_hours}\)"
echo "INFO: adrci Setting Long Purge Policy"
echo "INFO: Setting ADR Long purge policy to ${long_hours} hours "
adrci exec="set homepath $file_line;set control \(LONGP_POLICY=${long_hours}\)"
echo ""
echo ""
done
echo
echo "INFO: adrci setup finished at `date`"
