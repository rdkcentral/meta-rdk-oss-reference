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

# Parse command line arguments
ACTION=$1
INTERFACE=$2
shift 2
DNS_SERVERS=$*

LOG_FILE="/opt/logs/named.log"
BUILD_CONF_PATH="/etc/bind/named.conf.options"
SCRIPT_NAME="update_namedoptions.sh"

echo "`/bin/timestamp` [$SCRIPT_NAME] Action: $ACTION, Interface: $INTERFACE, DNS Servers: $DNS_SERVERS" >> $LOG_FILE

if [ "x$ACTION" != "xadd" ] && [ "x$ACTION" != "xremove" ]; then
    echo "`/bin/timestamp` [$SCRIPT_NAME] ERROR: Invalid action '$ACTION'. Must be 'add' or 'remove'" >> $LOG_FILE
    exit 1
fi

DNS64_SERVER1=`tr181 -g Device.DeviceInfo.X_RDKCENTRAL-COM_RFC.Feature.DNS64Proxy.Server1 2>&1`
DNS64_SERVER2=`tr181 -g Device.DeviceInfo.X_RDKCENTRAL-COM_RFC.Feature.DNS64Proxy.Server2 2>&1`
DNS64_SERVER3=`tr181 -g Device.DeviceInfo.X_RDKCENTRAL-COM_RFC.Feature.DNS64Proxy.Server3 2>&1`
DNS64_SERVER4=`tr181 -g Device.DeviceInfo.X_RDKCENTRAL-COM_RFC.Feature.DNS64Proxy.Server4 2>&1`

RFC_BIND_ENABLED=`tr181 -g Device.DeviceInfo.X_RDKCENTRAL-COM_RFC.Feature.DNS64Proxy.Enable 2>&1`
if [ "x$RFC_BIND_ENABLED" = "x" ]; then
    RFC_BIND_ENABLED="true"
fi
APPENDER_STR="{ \n clients { any; };\n exclude { 64:FF9B::/96; ::ffff:0000:0000/96; }; \n suffix ::; \n };"
DNS64_STR=""
if [ "x$DNS64_SERVER1" != "x" ]; then
    DNS64_STR="$DNS64_STR \ndns64 $DNS64_SERVER1 $APPENDER_STR"
    echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Proxy Server1: $DNS64_SERVER1" >> $LOG_FILE
fi
if [ "x$DNS64_SERVER2" != "x" ]; then
    DNS64_STR="$DNS64_STR \ndns64 $DNS64_SERVER2 $APPENDER_STR"
    echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Proxy Server2: $DNS64_SERVER2" >> $LOG_FILE
fi
if [ "x$DNS64_SERVER3" != "x" ]; then
    DNS64_STR="$DNS64_STR \ndns64 $DNS64_SERVER3 $APPENDER_STR"
    echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Proxy Server3: $DNS64_SERVER3" >> $LOG_FILE
fi
if [ "x$DNS64_SERVER4" != "x" ]; then
    DNS64_STR="$DNS64_STR \ndns64 $DNS64_SERVER4 $APPENDER_STR"
    echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Proxy Server4: $DNS64_SERVER4" >> $LOG_FILE
fi

if [ "x$DNS64_STR" = "x" ]; then
    echo "`/bin/timestamp` [$SCRIPT_NAME] No DNS64 Proxy servers configured" >> $LOG_FILE
fi

if [ "x$RFC_BIND_ENABLED" = "xtrue" ]; then

    # Refresh the options again. Since resolver config can change while box is running.
    # Added the following to handle that case.

    if [ "$ACTION" = "remove" ]; then
        # Remove DNS servers for the specified interface
        if [ "$INTERFACE" = "eth0" ]; then
            sed -i '/\/\/eth0/,/\/\/wlan0/c\ \t\t//eth0\n\t\t//wlan0' $BUILD_CONF_PATH
            echo "`/bin/timestamp` [$SCRIPT_NAME] Removed DNS servers for eth0" >> $LOG_FILE
        else
            sed -i '/\/\/wlan0/,/\};/c\ \t\t//wlan0\n\t};' $BUILD_CONF_PATH
            echo "`/bin/timestamp` [$SCRIPT_NAME] Removed DNS servers for wlan0" >> $LOG_FILE
        fi
    elif [ "$ACTION" = "add" ]; then
        # Add DNS servers for the specified interface
        if [ "x$DNS_SERVERS" = "x" ]; then
            echo "`/bin/timestamp` [$SCRIPT_NAME] ERROR: No DNS servers provided for add action" >> $LOG_FILE
            exit 1
        fi

        # Add DNS servers one by one if not present
        for DNS in $DNS_SERVERS; do
            # Skip empty entries
            if [ "x$DNS" = "x" ]; then
                continue
            fi

            if grep -q "$DNS" $BUILD_CONF_PATH; then
                echo "`/bin/timestamp` [$SCRIPT_NAME] DNS server $DNS already present, skipping" >> $LOG_FILE
            else
                if [ "$INTERFACE" = "eth0" ]; then
                    sed -i "/\/\/eth0/a\ \t\t$DNS;" $BUILD_CONF_PATH
                else
                    sed -i "/\/\/wlan0/a\ \t\t$DNS;" $BUILD_CONF_PATH
                fi
                echo "`/bin/timestamp` [$SCRIPT_NAME] Added DNS server $DNS for $INTERFACE" >> $LOG_FILE
            fi
        done
    fi

    if [ "x$DNS64_STR" != "x" ];  then
        sed -i "s#\/\/DNS64#$DNS64_STR#g" $BUILD_CONF_PATH
        echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Servers are Configured" >>$LOG_FILE
    else
        echo "`/bin/timestamp` [$SCRIPT_NAME] DNS64 Servers not Configured, Empty" >>$LOG_FILE
    fi

    if [ -f /usr/sbin/named -o -f /media/apps/bind-dl/usr/sbin/named ];then
        pkill -HUP named
        systemctl restart named.service
        echo "`/bin/timestamp` [$SCRIPT_NAME] Bind Support is enabled, named is used for  DNS Resolutions." >> $LOG_FILE
        if [ -f /lib/rdk/logMilestone.sh ]; then
            sh /lib/rdk/logMilestone.sh "NAMED_STARTED"
        fi
    else
        echo "`/bin/timestamp` [$SCRIPT_NAME] Bind Support is enabled, named binary is not present, dns will fail" >> $LOG_FILE
    fi
else
    # This is to make sure atleast dnsmasq runs even if it fails initially. or some switch happened inbetween.
    echo "`/bin/timestamp` [$SCRIPT_NAME] Bind Support is not enabled" >> $LOG_FILE
    systemctl stop named.service
fi
