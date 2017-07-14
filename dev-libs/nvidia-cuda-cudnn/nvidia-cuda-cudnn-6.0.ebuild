# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PKG="cudnn-8.0-linux-x64-v6.0"
SRC_URI="${PKG}.tgz"

DESCRIPTION="NVIDIA cuDNN GPU Accelerated Deep Learning"
HOMEPAGE="https://developer.nvidia.com/cuDNN"

IUSE="+cuda_version_8_0"
REQUIRED_USE="cuda_version_8_0"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
RESTRICT="fetch"
LICENSE="NVIDIA-cuDNN"

QA_PREBUILT="opt/cuda/*"

S="${WORKDIR}/${PKG}"

DEPENDS=">=dev-util/nvidia-cuda-toolkit-8.0"

pkg_nofetch() {
	einfo "Please download"
	einfo "  - ${SRC_URI}"
	einfo "from ${HOMEPAGE} and place them in ${DISTDIR}"
}

src_unpack() {
	default
	mv "${WORKDIR}/cuda" "${S}"
}

src_install() {
	cd "${S}"

	pushd "lib64"
	
	into /opt/cuda
	ln -s "libcudnn.so.6.0.20" "libcudnn.so.6.0"
	dolib.so libcudnn*.so*
	dolib.a libcudnn_static.a

	popd


	pushd "include"

	insinto /opt/cuda/include
	doins cudnn.h

	popd
}
