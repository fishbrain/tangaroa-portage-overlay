# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit unpacker user eutils flag-o-matic cmake-utils toolchain-funcs

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
app-arch/xz-utils[static-libs]
dev-libs/libaio
>=dev-libs/libedit-2.11
>=sys-devel/gcc-4.6.3
>=sys-libs/glibc-2.16.0
>=dev-util/cmake-2.8.12
dev-db/mariadb[embedded]
sys-devel/bison
sys-devel/flex
dev-db/mariadb[embedded,static-libs]
jemalloc? ( dev-libs/jemalloc )
tcmalloc? ( dev-util/google-perftools )
rabbitmq? ( net-libs/rabbitmq-c )"

REQUIRED_USE="
    ${REQUIRED_USE} tcmalloc? ( !jemalloc ) jemalloc? ( !tcmalloc )
"

MAKEOPTS="-j1"

pkg_setup() {
	enewgroup maxscale
	enewuser maxscale -1 -1 -1 maxscale
}

S="${WORKDIR}/MaxScale-${PV}"

src_prepare() {
    append-cflags $(test-flags-CC -Wno-error)
	filter-flags -ftree-vectorize -floop-interchange -ftree-loop-distribution -floop-strip-mine -floop-block
	replace-flags -O3 -O2
	eapply "${FILESDIR}"/141_logmanager.patch
	eapply "${FILESDIR}"/141_rpath.patch
	eapply_user
	cmake-utils_src_prepare
	eapply "${FILESDIR}"/145_cmakelists.patch
}

src_configure() {
	local mycmakeargs=(
		-DWITH_SCRIPTS=OFF
		-DBUILD_BINLOG=$(usex binlog-router)
		-DBUILD_RABBITMQ=$(usex rabbitmq)
		-DWITH_JEMALLOC=$(usex jemalloc)
		-DWITH_TCMALLOC=$(usex tcmalloc)
		-DMODULE_INSTALL_PATH=$(get_libdir)/${PN}
		-DBUID_STATIC_LIBS=ON
		-DSTATIC_EMBEDDED=ON
		-DCMAKE_INSTALL_RPATH="${ROOT}/usr/lib64/maxscale:${ROOT}/usr/lib64/mysql/plugin:${ROOT}/usr/lib64/mysql"
	)
	cmake-utils_src_configure
}

src_install() {
	newinitd "${FILESDIR}/init-server-12" ${PN}
	newconfd "${FILESDIR}/confd-server-12" ${PN}
	local DOCS=( README "${BUILD_DIR}"/Changelog.txt "${BUILD_DIR}"/ReleaseNotes.txt )
	cmake-utils_src_install
	# Remove badly placed documents
	rm "${D}usr/share/${PN}/README" "${D}usr/share/${PN}/Changelog.txt" \
		"${D}usr/share/${PN}/LICENSE" "${D}usr/share/${PN}/COPYRIGHT" \
		"${D}usr/share/${PN}/ReleaseNotes.txt" || die
	keepdir /var/log/maxscale /var/lib/maxscale/data
	fowners maxscale:maxscale /var/log/maxscale \
		/var/lib/maxscale/data \
		/var/lib/maxscale
}

pkg_postinst() {
	ewarn ""
	ewarn "Before you can start Maxscale, you have to"
	ewarn "create /etc/maxscale.cnf"
	ewarn ""
	ewarn "You can use /etc/maxscale_template.cnf"
	ewarn "as an example."
}
