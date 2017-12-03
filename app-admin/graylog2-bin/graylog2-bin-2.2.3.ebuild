# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit user

DESCRIPTION="Free and open source log management"
HOMEPAGE="https://graylog.org"
SRC_URI="https://packages.graylog2.org/releases/graylog/graylog-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jdk:1.8
	dev-java/sigar:0"
RDEPEND="${DEPEND}"

MY_PN="graylog"
S="${WORKDIR}/${MY_PN}-${PV}"

INSTALL_DIR="/usr/share/graylog2"

pkg_setup() {
	enewgroup graylog
	enewuser graylog -1 -1 -1 graylog
}

src_prepare() {
	default
	# depend on system dev-java/sigar => delete the bundled one
	rm -r "${S}/lib"
	# graylogctl is replaced by our own initd
	rm -r "${S}/bin"
}

src_compile() {
	einfo "Binary only for now. Please contribute for a source ebuild"
}

src_install() {
	mkdir -p "${D}/etc/graylog2"
	mv "${S}/graylog.conf.example" "${D}/etc/graylog2"
	mkdir -p "${D}/${INSTALL_DIR}"
	cp -R "${S}"/* "${D}/${INSTALL_DIR}"
	newinitd "${FILESDIR}/initd" graylog2
	newconfd "${FILESDIR}/confd" graylog2
}
