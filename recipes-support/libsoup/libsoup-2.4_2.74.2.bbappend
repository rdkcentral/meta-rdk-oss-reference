FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	 file://soup_cookie_jar_limit_2_68.patch \
	 file://interleave_addresses.patch \
	 file://libsoup-devprotection_2_68.patch \
	 file://failed_tls_print_ip_address.patch \
	 file://error_on_incomplete_chunked_encoding.patch \
         file://0001-RDKB-44368-libsoup-2.68-Continuous-flooding-of-libso.patch \
	 file://DELIA-57838-cookie-jar-db-Fix-DB-access-BUSY-failure.patch \
	 file://DELIA-57540-Refresh-cookies-from-database-in-runtime.patch \
         file://0001-set-same_site_policy-to-NONE-if-COL_SAME_SITE_POLICY.patch \
"
