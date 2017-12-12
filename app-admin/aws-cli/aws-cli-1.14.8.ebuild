# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5} )
inherit distutils-r1

DESCRIPTION="Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://github.com/aws/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="dev-python/configargparse[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.8.6[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.2.5[${PYTHON_USEDEP}]
	!>=dev-python/colorama-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.10[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.1.2[${PYTHON_USEDEP}]
	!>dev-python/rsa-3.5.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
    >=dev-python/s3transfer-0.1.12[${PYTHON_USEDEP}]
	>=dev-python/wheel-0.24.0
	>=dev-python/tox-2.3.1
	!>=dev-python/tox-3.0.0
	>=dev-python/pyyaml-3.10"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	# Only run unit tests
	nosetests tests/unit || die "Tests fail with ${EPYTHON}"
}
