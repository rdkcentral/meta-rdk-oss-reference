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

touch /tmp/NMTESTFILE.txt
DT_TIME=$(date +'%Y-%m-%d:%H:%M:%S:%6N')

echo "$DT_TIME From 10-script.sh $1 $2" >> /tmp/NMTESTFILE.txt

interfaceName=$1
interfaceStatus=$2

if [ "x$interfaceName" != "x" ] && [ "$interfaceName" != "lo" ]; then
    if [ "$interfaceStatus" == "dhcp4-change" ]; then
	    echo "ipv4" >> /tmp/NMMode.txt
	  fi
    if [ "$interfaceStatus" == "up" ]; then
		  mode=`cat /tmp/NMMode.txt`
		  gwip=$(/sbin/ip -4 route | awk '/default/ { print $3 }' | head -n1 | awk '{print $1;}')
		  imode=2
		  if [ "x$mode" = "x" ]; then
		    mode="ipv6"
			  imode=10
			  gwip=$(/sbin/ip -6 route | awk '/default/ { print $3 }' | head -n1 | awk '{print $1;}')
		  fi
		
		  ipaddr=$(ifconfig $interfaceName | grep -w inet | cut -d 't' -f 2 | cut -d ' ' -f 2)
		
		  sh /lib/rdk/networkLinkEvent.sh $interfaceName "add"
		  echo "$DT_TIME networkLinkEvent.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/ipv6addressChange.sh "add" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME ipv6addressChange.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/networkInfoLogger.sh "add" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME networkInfoLogger.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/checkDefaultRoute.sh  $imode $interfaceName $ipaddr $gwip $interfaceName "metric" "add"
		  echo "$DT_TIME checkDefaultRoute.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/updateGlobalIPInfo.sh "add" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME updateGlobalIPInfo.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/ipmodechange.sh $imode $interfaceName $ipaddr $gwip $interfaceName "metric" "add"
		  echo "$DT_TIME ipmodechange.sh" >> /tmp/NMTESTFILE.txt
		
    elif [ "$interfaceStatus" == "down" ]; then
	    sh /lib/rdk/networkLinkEvent.sh $interfaceName "delete"
		  echo "$DT_TIME networkLinkEvent.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/ipv6addressChange.sh "delete" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME ipv6addressChange.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/networkInfoLogger.sh "delete" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME networkInfoLogger.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/checkDefaultRoute.sh  $imode $interfaceName $ipaddr $gwip $interfaceName "metric" "delete"
		  echo "$DT_TIME checkDefaultRoute.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/updateGlobalIPInfo.sh "delete" $mode $interfaceName $ipaddr "global"
		  echo "$DT_TIME updateGlobalIPInfo.sh" >> /tmp/NMTESTFILE.txt
		
		  sh /lib/rdk/ipmodechange.sh $imode $interfaceName $ipaddr $gwip $interfaceName "metric" "delete"
		  echo "$DT_TIME ipmodechange.sh" >> /tmp/NMTESTFILE.txt
	  fi
fi
