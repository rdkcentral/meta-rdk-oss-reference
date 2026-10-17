# Use locked sstate from host machine/docker
HOST_LOCKED_SSTATE_PATH ?= "/opt/locked_sstate"

def get_locked_sig_file(d):
    default_sigs_file = "locked-sigs.inc"
    host_locked_sstate_path = d.expand('${HOST_LOCKED_SSTATE_PATH}')

    default_tune = d.getVar('DEFAULTTUNE')
    # need to fix: Workaround to check for 64bit machine with multilib configuration
    multilib_support = d.getVar('MULTILIBS') or ""

    # Determine the correct sigs_file based on the configuration
    if multilib_support:
        sigs_file = "locked-sigs_rdk-arm64.inc"
    elif "armv7athf-neon" in default_tune:
        sigs_file = "locked-sigs_rdk-arm7a.inc"
    elif "armv7vethf-neon" in default_tune :
        sigs_file = "locked-sigs_rdk-arm7ve.inc"
    else:
        sigs_file = default_sigs_file
    sigs_file_path = os.path.join(host_locked_sstate_path, sigs_file)
    if os.path.exists(sigs_file_path):
        return sigs_file_path
    else:
        bb.fatal("ERROR: The expected locked sigs file(%s) is not found" %sigs_file_path)

SIG_FILE = "${@get_locked_sig_file(d)}"
include ${SIG_FILE}
SSTATE_MIRRORS += "file://.* file:///${HOST_LOCKED_SSTATE_PATH}/PATH"
SIGGEN_LOCKEDSIGS_TASKSIG_CHECK = "warn"
