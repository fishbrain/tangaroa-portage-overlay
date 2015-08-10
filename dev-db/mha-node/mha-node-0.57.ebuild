# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="MySQL master HA node"
HOMEPAGE="https://github.com/yoshinorim/mha4mysql-node"
EGIT_REPO_URI="git://github.com/yoshinorim/mha4mysql-node"
EGIT_COMMIT="cc38e28274ca31bca256ea60887495c788460aef"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/DBD-mysql \
        dev-perl/Module-Install"
RDEPEND="${DEPEND}
         !=dev-lang/perl-5.22.0"

src_configure() {
	perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1
}

src_install() {
	emake DESTDIR="${D}" install

	# From perl-module.eclass; remove extraneous perllocal.pod
	find "${D}" -type f -name perllocal.pod -delete
	find "${D}" -depth -mindepth 1 -type d -empty -delete
}
