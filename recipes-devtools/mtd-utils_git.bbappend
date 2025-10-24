PACKAGES:remove = "mtd-utils-misc"

PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = " \
    ${sbindir}/flashcp.mtd-util \
    ${sbindir}/flash_erase \
    ${sbindir}/flash_eraseall.mtd-utils \
    ${sbindir}/flash_lock.mtd-utils \
    ${sbindir}/flash_otp_dump \
    ${sbindir}/flash_otp_erase \
    ${sbindir}/flash_otp_info \
    ${sbindir}/flash_otp_lock \
    ${sbindir}/flash_otp_write \
    ${sbindir}flash_unlock.mtd-utils \
    "
