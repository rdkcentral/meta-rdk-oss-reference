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

python set_testuser1_password() {
    import subprocess
    import re
    import os

    rootfs = d.getVar('IMAGE_ROOTFS')
    machine_image_name = d.getVar('MACHINE_IMAGE_NAME')
    shadow_path = os.path.join(rootfs, 'etc', 'shadow')
    dropbear_default = os.path.join(rootfs, 'etc', 'default', 'dropbear')

    # --- Set password in /etc/shadow ---
    if not os.path.isfile(shadow_path):
        bb.warn("testuser1: %s not found — password not set" % shadow_path)
    else:
        result = subprocess.run(
            ['openssl', 'passwd', '-6', machine_image_name],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        if result.returncode != 0:
            bb.warn("testuser1: openssl passwd failed: %s" % result.stderr.decode().strip())
        else:
            encrypted_pass = result.stdout.decode().strip()
            with open(shadow_path, 'r') as f:
                content = f.read()
            if not re.search(r'^testuser1:', content, re.MULTILINE):
                bb.warn("testuser1: entry not found in %s — password not set" % shadow_path)
            else:
                new_content = re.sub(
                    r'^(testuser1:)[^:]*(:)',
                    lambda m: m.group(1) + encrypted_pass + m.group(2),
                    content,
                    flags=re.MULTILINE
                )
                with open(shadow_path, 'w') as f:
                    f.write(new_content)
                bb.note("testuser1: password set from MACHINE_IMAGE_NAME (%s)" % machine_image_name)

    # --- Remove -w from DROPBEAR_EXTRA_ARGS ---
    # dropbear ships with -w which blocks all UID 0 password logins.
    # testuser1 has UID 0, so -w must be removed for password auth to work.
    if os.path.isfile(dropbear_default):
        with open(dropbear_default, 'r') as f:
            db_content = f.read()
        if '-w' in db_content:
            new_db_content = re.sub(r'\s*-w\b', '', db_content)
            with open(dropbear_default, 'w') as f:
                f.write(new_db_content)
            bb.note("testuser1: removed -w from DROPBEAR_EXTRA_ARGS in %s" % dropbear_default)
}
