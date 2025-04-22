#!/bin/sh
##############################################################################
# If not stated otherwise in this file or this component's LICENSE file the
# following copyright and licenses apply:
#
# Copyright 2020 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################

if [ -f /etc/device.properties ];then
     . /etc/device.properties
fi

if [ -f /lib/rdk/t2Shared_api.sh ]; then
    source /lib/rdk/t2Shared_api.sh
fi

LOG_FILE="/opt/logs/named.log"

resolvFile=/etc/resolv.dnsmasq

echo "-------- named_start_post_rdm BEGIN" >>$LOG_FILE

ipv4=0
ipv6=0
DNS_ADDR=""
while read -r line; do
	 ADDR=`echo $line | cut -d " " -f2`
	 if [ "$line" != "${line#*[0-9].[0-9]}" ]; then
		 ipv4=$((ipv4 +1))
		 DNS_ADDR="$DNS_ADDR \n$ADDR;"
	elif [ "$line" != "${line#*:[0-9a-fA-F]}" ]; then
		 ipv6=$((ipv6 +1))
		 DNS_ADDR="$DNS_ADDR \n$ADDR;"
	 else
		 echo "Unrecognized IP format '$line'" >>$LOG_FILE
	 fi
done<$resolvFile

echo "-------- named_start_post_rdm END" >>$LOG_FILE

