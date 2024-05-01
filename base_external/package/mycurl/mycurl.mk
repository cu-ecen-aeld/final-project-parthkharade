################################################################################
#
# mycurl
#
################################################################################

MYCURL_VERSION = 7.68.0
MYCURL_SOURCE = curl-$(CURL_VERSION).tar.gz
MYCURL_SITE = https://curl.se/download
MYCURL_INSTALL_STAGING = YES
MYCURL_INSTALL_TARGET = YES
MYCURL_CONF_OPTS = --with-ssl
MYCURL_DEPENDENCIES = openssl

$(eval $(autotools-package))
