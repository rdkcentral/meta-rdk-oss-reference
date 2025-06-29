#!/bin/sh

CONFIG_FILE="/usr/bin/GetConfigFile"
RDKSSACLI="/usr/bin/rdkssacli"
DEVICE_CERT="devicecert_1.pk12"
SE_DEVICE_CERT="devicecert_2.pk12"
STATIC_CERT="/etc/ssl/certs/staticXpkiCrt.pk12"
XPKIEXTRACT="/tmp/.adzvfchigc1ssa"
CERT_FILE="/tmp/.adzvfchigc1ssaf1"
CA_FILE="/tmp/.adzvfchigc1ssaf2"


RDK_SSA_CREDS=("kjvrverlzhlo" "kquhqtoczcbx" "mamjwwgtfwpa")
GET_CONFIG_CREDS=("/tmp/.cfgDynamicSExpki" "/tmp/.cfgDynamicxpki" "/tmp/.cfgStaticxpki")

echo_t()
{
    echo "`date +"%y%m%d-%T.%6N"` $1"
}


if [ -f $RDK_PATH/t2Shared_api.sh ]; then
    source $RDK_PATH/t2Shared_api.sh
fi

extract_stunnel_client_cert()
{
    if [ -f $CERT_FILE -a -f $CA_FILE ]; then
        echo_t "STUNNEL: Extracted cert & CA file already available"
        return
    elif [ -f $DEVICE_CERT_PATH/$SE_DEVICE_CERT -a "x$UseSEBasedCert" == "xtrue" -a ! -f /tmp/.$SE_DEVICE_CERT ]; then
        echo_t "STUNNEL: Using SE dynamic cert"
        CRED_INDEX=0
        CERT_PATH=$DEVICE_CERT_PATH/$SE_DEVICE_CERT
    elif [ -f $DEVICE_CERT_PATH/$DEVICE_CERT ]; then
        echo_t "STUNNEL: Using dynamic cert"
        CERT_PATH=$DEVICE_CERT_PATH/$DEVICE_CERT
        CRED_INDEX=1
    elif [ -f $STATIC_CERT ]; then
        echo_t "STUNNEL: No $DEVICE_CERT_PATH/$DEVICE_CERT using static cert"
        UPTIME=$(cut -d' ' -f1 /proc/uptime)
        echo_t "xPKIStaticCert: /etc/ssl/certs/staticDeviceCert.pk12 uptime $UPTIME seconds,$0"
        if [ -f /lib/rdk/t2Shared_api.sh ]; then
            t2ValNotify "SYS_INFO_xPKI_Static_Fallback" "xPKIStaticCert: /etc/ssl/certs/staticDeviceCert.pk12 uptime $UPTIME seconds,$0"
        fi
        CERT_PATH=$STATIC_CERT
        CRED_INDEX=2
    else
        echo_t "STUNNEL: No valid certs present. Exiting..."
        exit 1
    fi

    if [ -f $RDKSSACLI ]; then
        PASSCODE="$RDKSSACLI '{STOR=GET,SRC=${RDK_SSA_CREDS[$CRED_INDEX]},DST=/dev/stdout}'"
    elif [ -f $CONFIG_FILE ]; then
        PASSCODE="$CONFIG_FILE ${GET_CONFIG_CREDS[$CRED_INDEX]} stdout"
    else
        echo_t "STUNNEL: No valid method to obtain passcode. Exiting..."
        exit 1
    fi

    if [ "$DEVICE_TYPE" == "broadband" ]; then
        echo_t "STUNNEL: Skip cert and key extraction for XB"
    else
        eval $PASSCODE | openssl pkcs12 -nodes -passin stdin -in $CERT_PATH -out $XPKIEXTRACT
        ret=$?
        if [ $ret -ne 0 ]; then
            rm -f $XPKIEXTRACT
            echo_t "STUNNEL: Cert extraction failed. Exiting..."
            exit $ret
        fi

        sed -n '/--BEGIN PRIVATE KEY--/,/--END PRIVATE KEY--/p; /--END PRIVATE KEY--/q' $XPKIEXTRACT  > $CERT_FILE
        sed -n '/--BEGIN CERTIFICATE--/,/--END CERTIFICATE--/p; /--END CERTIFICATE--/q' $XPKIEXTRACT  >> $CERT_FILE
        rm -f $XPKIEXTRACT
    fi
    eval $PASSCODE | openssl pkcs12 -cacerts -nokeys -passin stdin -in $CERT_PATH |  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $CA_FILE
    ret=$?
    if [ $ret -ne 0 ]; then
        echo_t "STUNNEL: CA file extraction failed. Exiting..."
        rm -f $CERT_FILE
        exit $ret
    fi
}
