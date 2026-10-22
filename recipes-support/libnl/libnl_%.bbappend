PACKAGE_BEFORE_PN += "${PN}-extras"

FILES:${PN}-extras =  "\
                        ${libdir}/libnl/cli/cls/basic.so \
                        ${libdir}/libnl/cli/cls/cgroup.so \
                        ${libdir}/libnl/cli/qdisc/bfifo.so \
                        ${libdir}/libnl/cli/qdisc/blackhole.so \
                        ${libdir}/libnl/cli/qdisc/fq_codel.so \
                        ${libdir}/libnl/cli/qdisc/hfsc.so \
                        ${libdir}/libnl/cli/qdisc/htb.so \
                        ${libdir}/libnl/cli/qdisc/ingress.so \
                        ${libdir}/libnl/cli/qdisc/pfifo.so \
                        ${libdir}/libnl/cli/qdisc/plug.so \
"
