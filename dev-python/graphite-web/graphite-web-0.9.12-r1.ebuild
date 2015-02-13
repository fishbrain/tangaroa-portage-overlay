# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1

DESCRIPTION="Enterprise scalable realtime graphing"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="-apache2 +sqlite mysql postgres"

DEPEND=""
RDEPEND="${DEPEND}
	sqlite? ( dev-lang/python[sqlite]
			  dev-python/django[sqlite] )
	dev-python/carbon
	=dev-python/django-1.5*
	dev-python/pycairo
	dev-python/twisted-core
	dev-python/whisper
	apache2? ( www-apache/mod_wsgi )
	dev-python/django-tagging"

REQUIRED_USE="|| ( sqlite mysql postgres )"

src_prepare() {
	# This sets prefix to /opt/graphite. We want FHS-style paths instead.
	rm setup.cfg || die
	# Do not install the configuration and data files. We install them
	# somewhere sensible by hand.
	epatch "${FILESDIR}/no-data-files.patch"
	epatch "${FILESDIR}/${PV}-local_settings.patch"

	elog "${S}"

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	insinto /etc/${PN}
	doins conf/*

	dodoc examples/*

	dodir /usr/share/${PN}
	cp -r "${S}"/webapp "${D}"/usr/share/${PN} || die "webapp install failed"

	for x in "${D}"/usr/lib64/python*/site-packages/graphite/ ; do
		ln -s /etc/${PN}/local_settings.py $x/local_settings.py
		ln -s /usr/share/${PN}/webapp/graphite/templates $x/templates
	done
	ln -s /etc/${PN}/local_settings.py "${D}"/usr/share/${PN}/webapp/graphite/local_settings.py
}
pkg_postinst() {
	elog "See /etc/${PN}/wsgi.py.example for wsgi app."
	elog "Don't forget to add local_settings.py, .example in /usr/share/${PN}/webapp/"
	ewarn "Note that Webapp root is moved in 0.9.10-r3 from /usr/share/${PN}"
	ewarn "to /usr/share/${PN}/webapp, and after update you need to change"
	ewarn "CONTENT_DIR in your local_settings.py (see .example),"
	ewarn "move wsgi.py and/or update webserver configs"
	ewarn "If this is a new install, you should create local_settings.py according to"
	ewarn "your needs. See local_settings.py.examples in /usr/share/${PN}/webapp/graphite"
	ewarn "for a template."
}
