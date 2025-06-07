# this file is already provided by sysint, which is not right
# right way would be to write a iptable bbappend and add it via
# that, but for now lets remove iptables to be provider of this
# file for rdk
#
do_install:append() {
	rm -rf ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:iptables:remove = "iptables.service ip6tables.service"

RDEPENDS:iptables-modules:remove = " \
									iptables-module-ip6t-ah \
									iptables-module-ip6t-dnpt \
									iptables-module-ip6t-dst \
									iptables-module-ip6t-eui64 \
									iptables-module-ip6t-frag \
									iptables-module-ip6t-hbh \
									iptables-module-ip6t-hl \
									iptables-module-ip6t-icmp6 \
									iptables-module-ip6t-ipv6header \
									iptables-module-ip6t-log \
									iptables-module-ip6t-mh \
									iptables-module-ip6t-netmap \
									iptables-module-ip6t-redirect \
									iptables-module-ip6t-rt \
									iptables-module-ip6t-snpt \
									iptables-module-ipt-ah \
									iptables-module-ipt-clusterip \
									iptables-module-ipt-ecn \
									iptables-module-ipt-icmp \
									iptables-module-ipt-log \
									iptables-module-ipt-netmap \
									iptables-module-ipt-realm \
									iptables-module-ipt-redirect \
									iptables-module-ipt-ttl \
									iptables-module-ipt-ulog \
									iptables-module-xt-addrtype \
									iptables-module-xt-audit \
									iptables-module-xt-bpf \
									iptables-module-xt-cgroup \
									iptables-module-xt-checksum \
									iptables-module-xt-classify \
									iptables-module-xt-cluster \
									iptables-module-xt-connbytes \
									iptables-module-xt-connlimit \
									iptables-module-xt-connmark \
									iptables-module-xt-connsecmark \
									iptables-module-xt-cpu \
									iptables-module-xt-ct \
									iptables-module-xt-dccp \
									iptables-module-xt-devgroup \
									iptables-module-xt-dscp \
									iptables-module-xt-ecn \
									iptables-module-xt-esp \
									iptables-module-xt-helper \
									iptables-module-xt-led \
									iptables-module-xt-length \
									iptables-module-xt-limit \
									iptables-module-xt-mac \
									iptables-module-xt-mark \
									iptables-module-xt-multiport \
									iptables-module-xt-nfacct \
									iptables-module-xt-nflog \
									iptables-module-xt-nfqueue \
									iptables-module-xt-osf \
									iptables-module-xt-owner \
									iptables-module-xt-pkttype \
									iptables-module-xt-policy \
									iptables-module-xt-rateest \
									iptables-module-xt-recent \
									iptables-module-xt-rpfilter \
									iptables-module-xt-sctp \
									iptables-module-xt-secmark \
									iptables-module-xt-set \
									iptables-module-xt-socket \
									iptables-module-xt-statistic \
									iptables-module-xt-string \
									iptables-module-xt-synproxy \
									iptables-module-xt-tcpmss \
									iptables-module-xt-tcpoptstrip \
									iptables-module-xt-tee \
									iptables-module-xt-time \
									iptables-module-xt-tos \
									iptables-module-xt-tproxy \
									iptables-module-xt-trace \
									iptables-module-xt-u32  \
"
