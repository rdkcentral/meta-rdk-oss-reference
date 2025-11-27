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

# Determine interface type (eth0 or wlan0)
IFACE_TYPE=""
case "$INTERFACE" in
    eth*)
        IFACE_TYPE="eth0"
        ;;
    wlan*)
        IFACE_TYPE="wlan0"
        ;;
    *)
        echo "`/bin/timestamp` nm-dispatcher: Unknown interface type: $INTERFACE" >> $LOG_FILE
        exit 0
        ;;
esac

case "$ACTION" in
    up|dhcp4-change|dhcp6-change)
        # Check if resolv.dnsmasq exists and has DNS servers
        if [ -f /etc/resolv.dnsmasq ] && [ -s /etc/resolv.dnsmasq ]; then
            DNS_ADDR=""
            while read -r line; do
                ADDR=$(echo $line | cut -d " " -f2)
                if [ "$line" != "${line#*[0-9].[0-9]}" ]; then
                    # IPv4
                    DNS_ADDR="$DNS_ADDR \n$ADDR;"
                    echo "`/bin/timestamp` nm-dispatcher: Found IPv4 DNS server: $ADDR" >> $LOG_FILE
                elif [ "$line" != "${line#*:[0-9a-fA-F]}" ]; then
                    # IPv6
                    DNS_ADDR="$DNS_ADDR \n$ADDR;"
                    echo "`/bin/timestamp` nm-dispatcher: Found IPv6 DNS server: $ADDR" >> $LOG_FILE
                fi
            done < /etc/resolv.dnsmasq

            # Call update_namedoptions.sh with interface-specific DNS servers
            if [ -n "$DNS_ADDR" ] && [ -n "$IFACE_TYPE" ]; then
                if [ -f /lib/rdk/update_namedoptions.sh ]; then
                    # First remove old DNS servers for this interface
                    echo "`/bin/timestamp` nm-dispatcher: Removing old DNS servers for $IFACE_TYPE" >> $LOG_FILE
                    /bin/sh /lib/rdk/update_namedoptions.sh remove $IFACE_TYPE

                    # Then add new DNS servers for this interface
                    echo "`/bin/timestamp` nm-dispatcher: Adding DNS servers for $IFACE_TYPE: $DNS_ADDR" >> $LOG_FILE
                    /bin/sh /lib/rdk/update_namedoptions.sh add $IFACE_TYPE $DNS_ADDR
                fi
            else
                echo "`/bin/timestamp` nm-dispatcher: No DNS servers found " >> $LOG_FILE
            fi
        fi
        ;;
    down)
        # When interface goes down, remove its DNS servers
        if [ -n "$IFACE_TYPE" ]; then
            if [ -f /lib/rdk/update_namedoptions.sh ]; then
                echo "`/bin/timestamp` nm-dispatcher: Removing DNS servers for $IFACE_TYPE (interface down)" >> $LOG_FILE
                /bin/sh /lib/rdk/update_namedoptions.sh remove $IFACE_TYPE
            fi
        fi
        ;;
esac

exit 0
