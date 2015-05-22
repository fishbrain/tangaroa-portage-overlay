# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit unpacker user eutils

SRC_URI="https://github.com/mariadb-corporation/MaxScale/archive/${PV}.tar.gz"
KEYWORDS=""
SLOT="0"

DESCRIPTION="MaxScale is an intelligent proxy"
HOMEPAGE="https://github.com/mariadb-corporation/MaxScale"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="binlog-router jemalloc rabbitmq log-sessions-at-message-level tcmalloc"

RDEPEND=""
DEPEND="${RDEPEND}
dev-libs/libaio
>=sys-devel/gcc-4.6.3
>=sys-libs/glibc-2.16.0
>=dev-util/cmake-2.8.12
dev-db/mariadb[embedded]
virtual/mysql[embedded]
jemalloc? ( dev-libs/jemalloc )
tcmalloc? ( dev-utils/google-perftools )
rabbitmq? ( dev-libs/rabbitmq-c )"

REQUIRED_USE="
    ${REQUIRED_USE} tcmalloc? ( !jemalloc ) jemalloc? ( !tcmalloc )
"

pkg_setup() {
	enewgroup maxscale
	enewuser maxscale -1 -1 /opt/maxscale maxscale
}

S="${WORKDIR}/MaxScale-${PVR}"

src_prepare() {
  if use log-sessions-at-message-level; then
    epatch "${FILESDIR}"/session.c.log_session_start_at_message_level.patch
  fi
}

src_compile() {
    cmake_args="-DCMAKE_INSTALL_PREFIX=/usr/local/MaxScale -DSTATIC_EMBEDDED=FALSE -DINSTALL_SYSTEM_FILES=FALSE -DWITH_SCRIPTS=FALSE"

	if use binlog-router; then
	  cmake_args="$cmake_args -DBUILD_BINLOG=TRUE"
	fi

    if use rabbitmq; then
	  cmake_args="$cmake_args -DBUILD_RABBITMQ=TRUE"
	fi

    if use jemalloc; then
	  cmake_args="$cmake_args -DWITH_JEMALLOC=TRUE"
	fi

    if use tcmalloc; then
	  cmake_args="$cmake_args -DWITH_TCMALLOC=TRUE"
	fi

	mkdir ${S}/build
	cd ${S}/build
	cmake $cmake_args ..
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
