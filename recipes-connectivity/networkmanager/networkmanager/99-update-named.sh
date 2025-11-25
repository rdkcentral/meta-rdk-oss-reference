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

# NetworkManager dispatcher script to update BIND DNS64 configuration
# This script is called by NetworkManager when network events occur
#
# Note: NetworkManager updates /var/run/NetworkManager/no-stub-resolv.conf
# which is symlinked to /etc/resolv.dnsmasq

INTERFACE=$1
ACTION=$2
LOG_FILE="/opt/logs/named.log"

echo "`/bin/timestamp` nm-dispatcher: Interface=$INTERFACE Action=$ACTION" >> $LOG_FILE

case "$ACTION" in
    dhcp4-change|dhcp6-change)
        # Check if resolv.dnsmasq exists and has DNS servers
        if [ -f /etc/resolv.dnsmasq ] && [ -s /etc/resolv.dnsmasq ]; then
            # Extract DNS servers with semicolons
            DNS_ADDR=""
            while read -r line; do
                ADDR=$(echo $line | cut -d " " -f2)
                if [ "$line" != "${line#*[0-9].[0-9]}" ]; then
                    # IPv4
                    DNS_ADDR="$DNS_ADDR $ADDR;"
                    echo "`/bin/timestamp` nm-dispatcher: Found IPv4 DNS server: $ADDR" >> $LOG_FILE
                elif [ "$line" != "${line#*:[0-9a-fA-F]}" ]; then
                    # IPv6
                    DNS_ADDR="$DNS_ADDR $ADDR;"
                    echo "`/bin/timestamp` nm-dispatcher: Found IPv6 DNS server: $ADDR" >> $LOG_FILE
                fi
            done < /etc/resolv.dnsmasq

            # Call update_namedoptions.sh with DNS servers
            if [ -n "$DNS_ADDR" ]; then
                if [ -f /lib/rdk/update_namedoptions.sh ]; then
                    echo "`/bin/timestamp` nm-dispatcher: Updating BIND configuration with DNS servers: $DNS_ADDR" >> $LOG_FILE
                    /bin/sh /lib/rdk/update_namedoptions.sh $DNS_ADDR
                else
                    echo "`/bin/timestamp` nm-dispatcher: ERROR - /lib/rdk/update_namedoptions.sh not found" >> $LOG_FILE
                fi
            fi
        fi
        ;;
esac

exit 0
