# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit unpacker user eutils

SRC_URI="https://github.com/mariadb-corporation/MaxScale/archive/1.1.0.tar.gz"
KEYWORDS=""
SLOT="0"

DESCRIPTION="MaxScale is an intelligent proxy"
HOMEPAGE="https://github.com/mariadb-corporation/MaxScale"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
>=sys-devel/gcc-4.6.3
>=sys-libs/glibc-2.16.0
>=dev-util/cmake-2.8.12
dev-db/mariadb[embedded]
virtual/mysql[embedded]"

pkg_setup() {
	enewgroup maxscale
	enewuser maxscale -1 -1 /opt/maxscale maxscale
}

S="${WORKDIR}/MaxScale-1.1.0"

src_prepare() {
	epatch "${FILESDIR}"/macros.cmake.patch
}

src_compile() {
	mkdir ${S}/build
	cd ${S}/build
	cmake -DCMAKE_INSTALL_PREFIX=/usr/local/MaxScale -DSTATIC_EMBEDDED=FALSE -DINSTALL_SYSTEM_FILES=FALSE ..
	emake || die
}

src_install() {
	cd ${S}/build
	emake install DESTDIR="${D}" || die
	chown -R maxscale:maxscale "${D}"
	newinitd "${FILESDIR}/init-server" ${PN}
	newconfd "${FILESDIR}/confd-server" ${PN}
}

pkg_postinst() {
	ewarn ""
	ewarn "Before you can start Maxscale, you have to"
	ewarn "create /usr/local/MaxScale/etc/MaxScale.cnf."
	ewarn ""
	ewarn "You can use /usr/local/MaxScale/etc/MaxScale_template.cnf"
	ewarn "as an example."
}
