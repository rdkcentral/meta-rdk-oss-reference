#!/bin/sh

####################################################################################
# If not stated otherwise in this file or this component's LICENSE file the
# following copyright and licenses apply:
#
# Copyright 2024 Comcast Cable Communications Management, LLC
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
####################################################################################

source /etc/utopia/service.d/log_env_var.sh
#LOGFILE=/var/lib/dibbler/server.sh-log

# uncomment this to get full list of available variables
#set >> $LOGFILE

echo "------------- $1 -------------" >> $LOGFILE

if [ "x$PREFIX1" != "x" ]; then
    echo "....$1 route for Prefix= ${PREFIX1} Prefix length= $PREFIX1LEN Remote Addr= $REMOTE_ADDR IFName= $IFACE ..." >> $LOGFILE
    if [ "$1" == "add" ]; then
       ip -6 route add ${PREFIX1}/$PREFIX1LEN via $REMOTE_ADDR dev $IFACE
    fi
    if [ "$1" == "update" ]; then
       ip -6 route add ${PREFIX1}/$PREFIX1LEN via $REMOTE_ADDR dev $IFACE
    fi
    if [ "$1" == "delete" ]; then
       ip -6 route del ${PREFIX1}/$PREFIX1LEN via $REMOTE_ADDR dev $IFACE
    fi
else
    echo "Prefix Address is NULL ..." >> $LOGFILE
fi
