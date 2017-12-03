# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Tools to help document botocore-based projects"
HOMEPAGE="https://github.com/lyst/lightfm"
SRC_URI="https://github.com/lyst/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
    dev-python/numpy[${PYTHON_USEDEP}]
    >=sci-libs/scipy-0.17.0[${PYTHON_USEDEP}]
    dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
    test? (
        dev-python/pytest[${PYTHON_USEDEP}]
        dev-python/scikit-learn[${PYTHON_USEDEP}]
    )"

python_test() {
    nosetests || die "Tests fail with ${EPYTHON}"
}
