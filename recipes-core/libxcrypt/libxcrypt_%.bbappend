inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash"

do_compile_ptest() {
    oe_runmake check TESTS=
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/test
    # Install compiled test binaries from libtool .libs directory
    for f in ${B}/test/.libs/*; do
        if [ -f "$f" ] && [ -x "$f" ]; then
            # Only install ELF binaries, skip .o and .la files
            case "$(basename "$f")" in
                *.o|*.la|*.lo) continue ;;
            esac
            install -m 0755 "$f" ${D}${PTEST_PATH}/test/
        fi
    done
}

# OE6 wrynose: [build-deps]/[file-rdeps] bash runtime-only; ptest not in vanilla OE list
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
# [missing-ptest] is a QARECIPETEST via oe.qa.handle_error() which checks ERROR_QA, not INSANE_SKIP
ERROR_QA:remove:wrynose = "missing-ptest"
