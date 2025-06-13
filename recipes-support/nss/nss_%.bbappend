PACKAGES =+ "${PN}-bin"

FILES:${PN}-bin = "\
    ${bindir} \
"

PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = " \
                        ${bindir}/rsaperf \
                        ${bindir}/pk11ectest \
                        ${bindir}/fipstest \
                        ${bindir}/bltest \
                        ${bindir}/ecperf \
                        ${bindir}/selfserv \
                        ${bindir}/fbectest \
                        ${bindir}/crmftest \
                        ${bindir}/tstclnt \
                        ${bindir}/ssltap \
                        ${bindir}/strsclnt \
                        ${bindir}/symkeyutil \
                        ${bindir}/vfyserv \
                        ${bindir}/httpserv \
                        ${bindir}/ocspclnt \
                        ${bindir}/rsapoptst \
                        ${bindir}/addbuiltin \
                        ${bindir}/vfychain \
                        ${bindir}/multinit \
                        ${bindir}/pk11importtest \
                        ${bindir}/sdrtest \
                        ${bindir}/pp \
                        ${bindir}/pk1sign \
                        ${bindir}/ocspresp \
                        ${bindir}/dbtest \
                        ${bindir}/remtest \
                        ${bindir}/chktest \
                        ${bindir}/makepqg \
                        ${bindir}/secmodtest \
                        ${bindir}/sdbthreadtst \
                        ${bindir}/pk11gcmtest \
                        ${bindir}/encodeinttest \
                        ${bindir}/mangle \
                        ${bindir}/baddbdir \
                        ${bindir}/dertimetest \
                        ${bindir}/conflict \
                        ${bindir}/nonspr10 \
"
