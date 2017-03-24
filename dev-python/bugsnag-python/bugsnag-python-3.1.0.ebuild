# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )
inherit distutils-r1

DESCRIPTION="Bugsnag"
HOMEPAGE="https://github.com/bugsnag/bugsnag-python"
SRC_URI="https://github.com/bugsnag/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PATCHES=( "${FILESDIR}"/setup.py.patch )

RDEPEND="
  dev-python/six[${PYTHON_USEDEP}]
  dev-python/webob[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
