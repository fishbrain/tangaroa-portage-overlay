# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="MySQL master HA manager"
HOMEPAGE="https://github.com/yoshinorim/mha4mysql-manager"
EGIT_REPO_URI="git://github.com/yoshinorim/mha4mysql-manager"
EGIT_COMMIT="fea77e93168c8212550c21f542fec48f5d978535"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Config-Tiny \
        dev-perl/DBD-mysql \
		dev-perl/log-dispatch \
        dev-perl/Module-Install \
		dev-perl/Parallel-ForkManager \
		perl-core/Time-HiRes"
RDEPEND="${DEPEND}"

src_configure() {
  perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1
}
