# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="MySQL master HA node"
HOMEPAGE="https://github.com/yoshinorim/mha4mysql-node"
EGIT_REPO_URI="git://github.com/yoshinorim/mha4mysql-node"
EGIT_COMMIT="ef26bdeeeb16c4c1c5e37bdaa276d118ffdd85e7"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/DBD-mysql \
        dev-perl/Module-Install"
RDEPEND="${DEPEND}"

src_configure() {
  perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1
}
