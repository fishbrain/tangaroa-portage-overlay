# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Segment Analytics"
HOMEPAGE="https://github.com/segmentio/analytics-python"
SRC_URI="https://github.com/segmentio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
  >=dev-python/six-1.5[${PYTHON_USEDEP}]
  >=dev-python/requests-2.7.0[${PYTHON_USEDEP}]
  >=dev-python/python-dateutil-2.1.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
