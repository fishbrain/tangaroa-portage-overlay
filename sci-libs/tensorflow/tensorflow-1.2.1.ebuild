# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
DISTUTILS_OPTIONAL=1

inherit python-r1 distutils-r1 versionator

MY_PV=$(replace_version_separator 3 '-')
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Computation using data flow graphs for scalable machine learning"
HOMEPAGE="https://www.tensorflow.org/"
SRC_URI="https://github.com/tensorflow/tensorflow/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 ZLIB MIT MPL-2.0 IJG"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+contrib +cuda debug gcp hdfs jemalloc mkl mpi -opencl verbs -xla
	+cuda_version_8_0
	cuda_compute_capabilities_2_0
	cuda_compute_capabilities_2_1
	cuda_compute_capabilities_3_5
	+cuda_compute_capabilities_3_7
	cuda_compute_capabilities_5_2
	cuda_compute_capabilities_6_0
	cuda_compute_capabilities_6_1
	+cudnn_version_6_0
"
REQUIRED_USE="cuda? ( ^^ ( cuda_version_8_0 ) )
	cuda? ( !opencl )
	cuda? ( || (
		cuda_compute_capabilities_2_0
		cuda_compute_capabilities_2_1
		cuda_compute_capabilities_3_5
		cuda_compute_capabilities_3_7
		cuda_compute_capabilities_5_2
		cuda_compute_capabilities_6_0
		cuda_compute_capabilities_6_1
	) )
	cuda? ( ^^ ( cudnn_version_6_0 ) )
"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
    cuda? (
		cuda_version_8_0? (
			cudnn_version_6_0? ( >=dev-libs/nvidia-cuda-cudnn-6.0[cuda_version_8_0] !>=dev-libs/nvidia-cuda-cudnn-6.1[profiler] )
		)
	)
	mkl? ( sci-libs/mkl )
	opencl? ( dev-util/computecpp )"
DEPEND="${RDEPEND}
	>=dev-util/bazel-0.3.2
	app-arch/unzip"

src_prepare() {
	eapply_user
	python_copy_sources
}

src_configure() {
    cuda_compute_capabilities=""

	if use cuda_compute_capabilities_2_0; then
		cuda_compute_capabilities+=",2.0"
	fi
	if use cuda_compute_capabilities_2_1; then
		cuda_compute_capabilities+=",2.1"
	fi
	if use cuda_compute_capabilities_3_5; then
		cuda_compute_capabilities+=",3.5"
	fi
	if use cuda_compute_capabilities_3_7; then
		cuda_compute_capabilities+=",3.7"
	fi
	if use cuda_compute_capabilities_5_2; then
		cuda_compute_capabilities+=",5.2"
	fi
	if use cuda_compute_capabilities_6_0; then
		cuda_compute_capabilities+=",6.0"
	fi
	if use cuda_compute_capabilities_6_1; then
		cuda_compute_capabilities+=",6.1"
	fi

	cuda_compute_capabilities="$(echo -n $cuda_compute_capabilities | cut -c2-)"

	cuda_version=""

	if use cuda_version_8_0; then
		cuda_version="8.0"
	fi

	cudnn_version=""

	if use cudnn_version_6_0; then
		cudnn_version="6.0"
	fi

	do_configure() {
		cd "${BUILD_DIR}" || die
		python_export PYTHON_SITEDIR

		einfo "Configuring for $PYTHON"
		CC_OPT_FLAGS="${CFLAGS}" \
			CUDNN_INSTALL_PATH="$(usex cuda "/opt/cuda")" \
			CUDA_TOOLKIT_PATH="$(usex cuda "/opt/cuda")" \
			GCC_HOST_COMPILER_PATH="/usr/bin/gcc" \
			HOST_C_COMPILER="cc" \
			HOST_CXX_COMPILER="c++" \
			TF_CUDNN_VERSION="$(usex cuda "${cudnn_version}")" \
			TF_CUDA_CLANG=0 \
			TF_CUDA_COMPUTE_CAPABILITIES="$(usex cuda "${cuda_compute_capabilities}")" \
			TF_CUDA_VERSION="$(usex cuda "${cuda_version}")" \
			TF_ENABLE_XLA=$(usex xla 1 0) \
			TF_NEED_GCP=$(usex gcp 1 0) \
			TF_NEED_HDFS=$(usex hdfs 1 0) \
			TF_NEED_MKL=$(usex mkl 1 0) \
			TF_NEED_MPI=$(usex mpi 1 0) \
			TF_NEED_OPENCL=$(usex opencl 1 0) \
			TF_NEED_CUDA=$(usex cuda 1 0) \
			TF_NEED_JEMALLOC=$(usex jemalloc 1 0) \
			TF_NEED_VERBS=$(usex verbs 1 0) \
			PYTHON_BIN_PATH="${PYTHON}" \
			PYTHON_LIB_PATH="${PYTHON_SITEDIR}" \
			./configure || die
		bazel shutdown || die
	}
	python_foreach_impl do_configure
}

src_compile() {
	if use cuda; then
 		cuda_config_flag="--config=cuda"
	else
		cuda_config_flag=""
	fi

	if use debug; then
		strip_flag="never"
		ewarn "Remember to set proper CFLAGS and CXXFLAGS such as -ggdb for debugging to work"
	else
		strip_flag="always"
	fi

	bazel_build() {
		cd "${BUILD_DIR}" || die
		CC_OPT_FLAGS="${CFLAGS}" \
			CUDNN_INSTALL_PATH="$(usex cuda "/opt/cuda")" \
			CUDA_TOOLKIT_PATH="$(usex cuda "/opt/cuda")" \
			GCC_HOST_COMPILER_PATH="/usr/bin/gcc" \
			HOST_C_COMPILER="cc" \
			HOST_CXX_COMPILER="c++" \
			TF_CUDNN_VERSION="$(usex cuda "${cudnn_version}")" \
			TF_CUDA_CLANG=0 \
			TF_CUDA_COMPUTE_CAPABILITIES="$(usex cuda "${cuda_compute_capabilities}")" \
			TF_CUDA_VERSION="$(usex cuda "${cuda_version}")" \
			TF_ENABLE_XLA=$(usex xla 1 0) \
			TF_NEED_GCP=$(usex gcp 1 0) \
			TF_NEED_HDFS=$(usex hdfs 1 0) \
			TF_NEED_MKL=$(usex mkl 1 0) \
			TF_NEED_MPI=$(usex mpi 1 0) \
			TF_NEED_OPENCL=$(usex opencl 1 0) \
			TF_NEED_CUDA=$(usex cuda 1 0) \
			TF_NEED_JEMALLOC=$(usex jemalloc 1 0) \
			TF_NEED_VERBS=$(usex verbs 1 0) \
			PYTHON_BIN_PATH="${PYTHON}" \
			PYTHON_LIB_PATH="${PYTHON_SITEDIR}" \
        bazel build \
			--verbose_failures \
			--spawn_strategy=standalone \
			--genrule_strategy=standalone \
			--compilation_mode=opt \
			$(for x in $CFLAGS; do echo -n "--copt=$x "; done) \
			$(for x in $CFLAGS; do echo -n "--host_copt=$x "; done) \
			$(for x in $CXXFLAGS; do echo -n "--cxxopt=$x "; done) \
			$(for x in $CXXFLAGS; do echo -n "--host_cxxopt=$x "; done) \
			$(for x in $LDFLAGS; do echo -n "--linkopt=$x "; done) \
			--strip="${strip_flag}" \
			${cuda_config_flag} \
			$1 || (bazel shutdown ; die)
	}

	do_compile() {
		einfo "Building PIP package"
		bazel_build "//tensorflow/tools/pip_package:build_pip_package"

		if use contrib; then
			einfo "Building contrib utilities"
			bazel_build "//tensorflow/contrib/util:convert_graphdef_memmapped_format"
		fi

		bazel shutdown || die

		mkdir _python_build || die
		cd _python_build || die
		ln -s ../bazel-bin/tensorflow/tools/pip_package/build_pip_package.runfiles/org_tensorflow/* ../tensorflow/tools/pip_package/* ./ || die
		esetup.py build
	}
	python_foreach_impl do_compile
}

src_install() {
	do_install() {
		cd "${BUILD_DIR}" || die
		cd _python_build || die
		esetup.py install
		if use contrib; then
			einfo "installing convert_graphdef_memmapped_format"
			if [ -r "${BUILD_DIR}/bazel-out/local_linux-opt/bin/tensorflow/contrib/util/convert_graphdef_memmapped_format" ]; then 
				dobin "${BUILD_DIR}/bazel-out/local_linux-opt/bin/tensorflow/contrib/util/convert_graphdef_memmapped_format" || die
			else
				dobin "${BUILD_DIR}/bazel-out/local_linux-py3-opt/bin/tensorflow/contrib/util/convert_graphdef_memmapped_format" || die
			fi
		fi
	}
	dodoc AUTHORS CONTRIBUTING.md ISSUE_TEMPLATE.md README.md RELEASE.md || die
	python_foreach_impl do_install
}
