EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit git-r3 python-r1

DESCRIPTION="caffe deep learning framework"
HOMEPAGE="http://caffe.berkeleyvision.org/"
LICENSE="BSD"
EGIT_REPO_URI="git://github.com/BVLC/caffe.git"
EGIT_COMMIT="2ef584785c8ade90260eb117f189146364494183"
EGIT_CLONE_TYPE="single"

IUSE="openblas openmp mkl atlas python opencv cuda"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
              ^^ ( openblas mkl atlas )
"

KEYWORDS="amd64 amd64-linux"
SLOT="1/${PV}"

DEPEND=">=dev-libs/boost-1.55
        dev-cpp/glog
        dev-db/lmdb
        sci-libs/hdf5
        dev-libs/leveldb[snappy]
        dev-libs/protobuf
        dev-cpp/gflags
		atlas? ( sci-libs/atlas )
        openblas? (
		  openmp? ( sci-libs/openblas[openmp] )
		  !openmp? ( sci-libs/openblas[-openmp] )
		)
        mkl? ( sci-libs/mkl )
        opencv? ( >=media-libs/opencv-3.0 )
        cuda? ( dev-util/nvidia-cuda-toolkit )
		python? (
		  >=dev-libs/boost-1.58[python]
		  >=dev-python/numpy-1.7[lapack]
		  sci-libs/scikits_image
          dev-libs/protobuf[python]
		  ${PYTHON_DEPS}
		) 
"

RDEPEND="${DEPEND}"

src_prepare() {
	if use openblas; then
		if use openmp; then
			sed 's/LIBRARIES += openblas/LIBRARIES += openblas_openmp/g' "${S}/Makefile" > "${S}/Makefile2"
			mv "${S}/Makefile2" "${S}/Makefile"
		fi
	fi

	if use python; then
		sed 's/boost_python/boost_python-2.7/g' "${S}/Makefile" > "${S}/Makefile2"
		mv "${S}/Makefile2" "${S}/Makefile"
	fi
}

src_configure() {
	config="${S}/Makefile.config"

	echo "BUILD_DIR := build" > "${config}"
	echo "DISTRIBUTE_DIR := distribute" >> "${config}"

	if use atlas; then
		echo "BLAS := atlas" >> "${config}"
	fi

	if use mkl; then
		echo "BLAS := mkl" >> "${config}"
	fi

	if use openblas; then
		echo "BLAS := open" >> "${config}"
		echo "BLAS_INCLUDE := /usr/include/openblas" >> "${config}"
	fi

	if ! use cuda; then
		echo "CPU_ONLY := 1" >> "${config}"
	else
		echo "CUDA_DIR=/opt/cuda" >> "${config}"
		echo "CUDA_ARCH := -gencode arch=compute_20,code=sm_20 \\" >> "${config}"
		echo "-gencode arch=compute_20,code=sm_21 \\" >> "${config}"
		echo "-gencode arch=compute_30,code=sm_30 \\" >> "${config}"
		echo "-gencode arch=compute_35,code=sm_35 \\" >> "${config}"
		echo "-gencode arch=compute_50,code=sm_50 \\" >> "${config}"
		echo "-gencode arch=compute_50,code=compute_50" >> "${config}"
	fi

	if use opencv; then
		echo "OPENCV_VERSION := 3" >> "${config}"
	fi

	if use python; then
		echo "PYTHON_INCLUDE := /usr/include/python2.7 \\" >> "${config}"
		echo "/usr/lib/python2.7/dist-packages/numpy/core/include" >> "${config}"
		echo "PYTHON_LIB := /usr/lib" >> "${config}"
		echo "INCLUDE_DIRS := \$(PYTHON_INCLUDE) /usr/local/include /usr/include /usr/lib64/python2.7/site-packages/numpy/core/include" >> "${config}"
		echo "LIBRARY_DIRS := \$(PYTHON_LIB) /usr/local/lib /usr/lib" >> "${config}"
	else
		echo "INCLUDE_DIRS := /usr/local/include /usr/include" >> "${config}"
		echo "LIBRARY_DIRS := /usr/local/lib /usr/lib" >> "${config}"
	fi
}

src_compile() {
	emake

	if use python; then
		emake pycaffe
	fi
}

src_install() {
	mkdir -p "${ED}"/usr/bin
	tar -C .build_release -c lib | tar -C "${ED}/usr" -x
	cp .build_release/tools/caffe.bin "${ED}"/usr/bin

	if use python; then
		mkdir -p "${ED}/usr/lib64/python2.7/site-packages"
		cp -R "${S}"/python/* "${ED}/usr/lib64/python2.7/site-packages"
	fi
}
