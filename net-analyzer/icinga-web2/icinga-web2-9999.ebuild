# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/icinga-web/icinga-web-1.11.2.ebuild,v 1.1 2014/10/16 23:34:09 prometheanfire Exp $

EAPI="5"

inherit depend.apache eutils user multilib git-2

DESCRIPTION="Icinga Web 2 - Newest Frontend for icinga2"
HOMEPAGE="http://www.icinga.org/"
EGIT_REPO_URI="git://git.icinga.org/icingaweb2.git"
LICENSE="GPL-2"
SLOT="0"
IUSE="apache2 ldap mysql nginx postgres"
DEPEND=">=net-analyzer/icinga2-2.1.1
		dev-lang/php[apache2?,cli,gd,json,intl,ldap?,mysql?,pdo,postgres?,sockets,ssl,xslt,xml]
		dev-php/pecl-imagick
		apache2? ( >=www-servers/apache-2.4.0 )
		nginx? ( >=www-servers/nginx-1.7.0 )"
RDEPEND="${DEPEND}"

want_apache2

pkg_setup() {
	if use apache2 ; then
		depend.apache_pkg_setup
	fi
	enewgroup icinga
	enewgroup nagios
	enewuser icinga -1 -1 /var/lib/icinga "icinga,nagios"
}

pkg_config() {
	if use apache2 ; then
		/usr/share/${PN}/bin/icingacli setup config webserver apache --document-root /usr/share/${PN}/public
	fi

	if use nginx ; then
		/usr/share/${PN}/bin/icingacli setup config webserver nginx --document-root /usr/share/${PN}/public
	fi
}

src_install() {
  mkdir -p "${D}/usr/share/${PN}"
  cp -R ${S}/* ${D}/usr/share/${PN}
  chmod -R a+rX ${D}/usr/share/${PN}/public
}

pkg_postinst() {
	einfo "You can run 'emerge --config net-analyzer/icinga-web2 if you're looking for the recommended web server configuration'"
}
