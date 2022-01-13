#!/bin/bash
###############################################################################
#
# update-facebook-ip-set.sh
# v1.0
# Created by beratnzp
#
# This script can crawl facebook current IPv4 blocks then update
# your selected AWS WAF IP Set. Then you can automate this script
# via crontab.
#
# CAUTION:
# On which EC2 Instance this script will run, you need to give that instance
# an "AWSWAFFullAccess" policy. If you want it to be more secure; you only
# need to authorize the list and edit of the IP Set you will use.
#
# Requirements:
# * jo
#
# Usage Example:
#
# ./update-ip-blocks.sh "AllowFacebookRobots" "cc293a64-94ey-40u9-8xc6-69z22"
#
###############################################################################

##########################
# DO NOT CHANGE OR DELETE
##########################
IPSETNAME=$1 #Prompt Parameter Example: AllowFacebookRobots
IPSETID=$2 #Prompt Parameter Example: cc293a64-94ey-40u9-8xc6-69z22
TIME="$(date +'%d-%m-%Y')"
##########################
# .DO NOT CHANGE OR DELETE
##########################

IPSETSCOPE="REGIONAL" # REGIONAL or CLOUDFRONT

# Crawl facebook current IPv4 Blocks
IPSETJSON=`whois -h whois.radb.net -- '-i origin AS32934' | grep ^route: | rev | cut -d ' ' -f1 | rev | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4|jo -a`

# Get selected IP Set Lock Token for update IP Set
IPSETLOCKTOKEN=`aws wafv2 get-ip-set --scope=$IPSETSCOPE --name=$IPSETNAME --id=$IPSETID  | jq '.LockToken' | cut -d '"' -f 2`

# Update the selected IP Set from the $IPSETJSON via $IPSETLOCKTOKEN
IPSETUPDATE=`aws wafv2 update-ip-set --scope=$IPSETSCOPE --name=$IPSETNAME --id=$IPSETID --lock-token=$IPSETLOCKTOKEN --addresses=$IPSETJSON`

# Print the output of $IPSETUPDATE process as a log file.
echo '[$TIME]-$IPSETUPDATE' >> update-facebook-ip-set.log
echo '#' >> update-facebook-ip-set.log
