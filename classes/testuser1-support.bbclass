##########################################################################
# If not stated otherwise in this file or this component's LICENSE
# file the following copyright and licenses apply:
#
# Copyright 2026 RDK Management
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
##########################################################################

# testuser1-support BitBake Class
#
# Creates a root-equivalent user 'testuser1' (UID 0) with a password
# equal to MACHINE_IMAGE_NAME for dropbear SSH access.
# Only applied to dev and vbn build variants (excluded from prod and prodlog).

SUMMARY = "Add testuser1: root-equivalent SSH user with MACHINE_IMAGE_NAME password"

inherit extrausers

# Create testuser1 with UID 0 (root-equivalent) for non-prod variants only.
# -u 0 -o: duplicate UID 0 (full root privileges)
# -g 0   : primary group = root
# -d     : share root's home directory
# -s     : login shell
# -M     : do not create a separate home directory
EXTRA_USERS_PARAMS:append = "${@'' if \
    bb.utils.contains('DISTRO_FEATURES', 'prod-variant',    True, False, d) or \
    bb.utils.contains('DISTRO_FEATURES', 'prodlog-variant', True, False, d) \
    else ' useradd -u 0 -o -g 0 -d /home/root -s /bin/sh -M testuser1; '}"

# Set testuser1 password to MACHINE_IMAGE_NAME for non-prod variants only.
ROOTFS_POSTPROCESS_COMMAND += "${@'' if \
    bb.utils.contains('DISTRO_FEATURES', 'prod-variant',    True, False, d) or \
    bb.utils.contains('DISTRO_FEATURES', 'prodlog-variant', True, False, d) \
    else 'set_testuser1_password; '}"

set_testuser1_password() {
    if grep -q "^testuser1:" "${IMAGE_ROOTFS}/etc/shadow" 2>/dev/null; then
        ENCRYPTED_PASS=$(openssl passwd -6 "${MACHINE_IMAGE_NAME}")
        sed -i "s|^testuser1:[^:]*:|testuser1:${ENCRYPTED_PASS}:|" "${IMAGE_ROOTFS}/etc/shadow"
        bbnote "testuser1: password set to MACHINE_IMAGE_NAME (${MACHINE_IMAGE_NAME}) in ${IMAGE_ROOTFS}/etc/shadow"
    else
        bbwarn "testuser1: entry not found in ${IMAGE_ROOTFS}/etc/shadow — password not set"
    fi
}
