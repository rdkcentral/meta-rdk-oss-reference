# Use locked sstate from host machine/docker
SSTATE_MIRRORS += "file://.* file:///${HOST_LOCKED_SSTATE_PATH}/PATH"
SIGGEN_LOCKEDSIGS_TASKSIG_CHECK = "warn"
include ${HOST_LOCKED_SSTATE_PATH}/locked-sigs.inc
