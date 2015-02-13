# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

WEBAPP_MANUAL_SLOT="yes"

inherit webapp eutils

DESCRIPTION="Client-side dashboard and graph editor for Graphite, InfluxDB & OpenTSDB"
HOMEPAGE="http://grafana.org/"
SRC_URI="http://grafanarel.s3.amazonaws.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
IUSE=""

RDEPEND=""
# ebuilds without WEBAPP_MANUAL_SLOT="yes" are broken
DEPEND="${RDEPEND}"
need_httpd

src_install() {
	webapp_src_preinst
	insinto "${MY_HTDOCSDIR}/"
	doins -r index.html app css font img
	newins config.sample.js config.js
	webapp_configfile "${MY_HTDOCSDIR}/config.js"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	einfo "Don't forget to edit config.js"
	einfo "Visit http://grafana.org/docs/ for more info."
}
