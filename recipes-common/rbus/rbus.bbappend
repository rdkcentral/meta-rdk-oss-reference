# OE6 migration (wrynose): cmake-native 4.x removed backward compatibility with
# cmake_minimum_required VERSION < 3.5. rbus CMakeLists.txt uses VERSION 2.8.12.
# Pass -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to suppress the fatal error.
EXTRA_OECMAKE:append:wrynose = " -DCMAKE_POLICY_VERSION_MINIMUM=3.5"

# GCC 15 defaults to -std=gnu23 where empty () in function definitions means void
# (no parameters). rbus has two functions declared as 'void f()' but called with
# (argc, argv). Also, glibc 2.43 const-correct strchr returns const char* for a
# const char* input; rbus.c assigns the result to char* which discards const.
# Use -std=gnu17 to restore C17 K&R-style () semantics and suppress const error.
TARGET_CFLAGS:append:wrynose = " -std=gnu17 -Wno-error=discarded-qualifiers"

# CMake 4.x makes CMP0046 permanently NEW and rejects cmake_policy(SET CMP0046 OLD)
# with a fatal error. CMP0046=NEW makes add_dependencies() a hard error when the
# dependency target doesn't exist. rbus CMakeLists.txt calls add_dependencies() on
# cjson, rdklogger, breakpad, msgpack and linenoise, which are found via
# find_package/pkg-config and are NOT cmake targets defined in this project.
# Fix: comment out or rewrite those specific add_dependencies calls before cmake
# processes them. Removing them is safe because actual link ordering is handled by
# target_link_libraries; add_dependencies here only redundantly requests ordering.
do_configure:prepend:wrynose() {
    # src/rtmessage: cjson, rdklogger, breakpad are external libs (not cmake targets)
    sed -i '/add_dependencies.*cjson/s/^/#OE6# /' "${S}/src/rtmessage/CMakeLists.txt"
    sed -i '/add_dependencies.*rdklogger/s/^/#OE6# /' "${S}/src/rtmessage/CMakeLists.txt"
    sed -i '/add_dependencies.*breakpad/s/^/#OE6# /' "${S}/src/rtmessage/CMakeLists.txt"
    # src/core: msgpack is external; preserve the internal rtMessage dependency
    sed -i 's/add_dependencies(rbuscore msgpack rtMessage)/add_dependencies(rbuscore rtMessage)/' "${S}/src/core/CMakeLists.txt"
    # utils/rbuscli: linenoise is external; preserve the internal rbus dependency
    sed -i 's/add_dependencies(rbuscli rbus linenoise)/add_dependencies(rbuscli rbus)/' "${S}/utils/rbuscli/CMakeLists.txt"
}

# OE6/docker: logrotate_config bbclass adds task do_write_metadata_logrotate which
# runs as a Python task AFTER do_install but BEFORE do_package. It writes
# .metadata files to ${D}/etc/logrotate/ while NOT running under fakeroot, so
# those files are owned by real uid 1023 (host user). Inside docker, uid 1023
# has no /etc/passwd entry; OEOuthashBasic's getpwuid(1023) throws KeyError.
# Removing in do_install:append would be too early — the bbclass re-creates them.
# do_package is a Python function so the prepend must also be Python.
python do_package:prepend:wrynose() {
    import shutil, os
    logrotate_dir = d.expand('${D}/etc/logrotate')
    if os.path.exists(logrotate_dir):
        shutil.rmtree(logrotate_dir)
}
