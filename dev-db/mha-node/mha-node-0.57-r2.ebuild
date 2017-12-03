# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 eutils

DESCRIPTION="MySQL master HA node"
HOMEPAGE="https://github.com/yoshinorim/mha4mysql-node"
EGIT_REPO_URI="https://github.com/yoshinorim/mha4mysql-node.git"
EGIT_COMMIT="1f6bc82cf0b37232ca810f33fd569c4b6d1b5887"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/DBD-mysql \
        dev-perl/Module-Install"
RDEPEND="${DEPEND} !=dev-lang/perl-5.22.0"

src_prepare() {
	epatch ${FILESDIR}/mha_057_perl522_compat.patch || die
}

src_configure() {
	perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1
}

src_install() {
	emake DESTDIR="${D}" install

	# From perl-module.eclass; remove extraneous perllocal.pod
	find "${D}" -type f -name perllocal.pod -delete
	find "${D}" -depth -mindepth 1 -type d -empty -delete
}
