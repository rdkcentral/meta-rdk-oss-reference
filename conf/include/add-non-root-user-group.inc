inherit extrausers
#-------------------------------------------------------------------------------
# Common groups
#-------------------------------------------------------------------------------
EXTRA_USERS_PARAMS += "\
    groupadd -g 850 testuser      ; \
"
#-------------------------------------------------------------------------------
# Common users and groups for OENMW
# For each user also the group with the same name and id is created.
#-------------------------------------------------------------------------------
PASSWD = '$6$RBrxXeTT3IuDGYWt$AOTQkp6iDEUzva3ovSEm0yThMvekG1uXl/mxAFhJ8v79XBNLYMyikX7Dxsk4.C/ddtPteHaPoWT5Qh67L2CIf0'
EXTRA_USERS_PARAMS += "\
    useradd -u 850 -g testuser -m -s /bin/sh -p '${PASSWD}' testuser; \
"
