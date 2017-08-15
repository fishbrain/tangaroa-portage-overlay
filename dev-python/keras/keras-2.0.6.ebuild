# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Keras"
HOMEPAGE="https://github.com/fchollet/keras"
SRC_URI="https://github.com/fchollet/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hdf5 visualize"

RDEPEND="
  dev-python/pyyaml[${PYTHON_USEDEP}]
  dev-python/six[${PYTHON_USEDEP}]
  dev-python/theano[${PYTHON_USEDEP}]
  hdf5? ( dev-python/h5py[${PYTHON_USEDEP}] )
  visualize? ( >=dev-python/pydot-1.2.0 )
"
DEPEND="${RDEPEND}"
