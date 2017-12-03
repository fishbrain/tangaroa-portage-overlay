# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit java-pkg-2 java-ant-2

MY_PN="netty"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="System Information Gatherer And Reporter"
HOMEPAGE="https://support.hyperic.com/display/SIGAR/Home"
SRC_URI="mirror://sourceforge/sigar/1.6/hyperic-${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.4"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
    dev-java/cpptasks
	>=dev-lang/perl-5.6.1"

S="${WORKDIR}/hyperic-${P}-src"
EANT_BUILD_XML="bindings/java/build.xml"

JAVA_PKG_FORCE_ANT_TASKS="all"
#JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH="ant-core,cpptasks"
EANT_NEEDS_TOOLS="true"

src_prepare() {
  epatch ${FILESDIR}/jni-build.${PV}.patch
  epatch ${FILESDIR}/sigar-inline.${PV}.patch
}

src_compile() {
  PATCHFILE="${WORKDIR}/jni-build.patch"
  COUNTERSTART=6
  REPLACESTRING="tktktktk"

  counter=${COUNTERSTART}
  echo "--- a/bindings/java/hyperic_jni/jni-build.xml       2016-06-25 15:17:08.487747593 +0000" > ${PATCHFILE}
  echo "+++ b/bindings/java/hyperic_jni/jni-build.xml       2016-06-25 15:20:25.982657304 +0000" >> ${PATCHFILE}
  echo "@@ -186,8 +186,${REPLACESTRING} @@" >> ${PATCHFILE}
  echo ""  >> ${PATCHFILE}
  echo "       <!-- Linux -->" >> ${PATCHFILE}
  echo "       <compiler name=\"gcc\" debug=\"\${jni.debug}\" if=\"linux\">" >> ${PATCHFILE}
  echo "-        <compilerarg value=\"-O2\" if=\"jni.optim\"/>" >> ${PATCHFILE}
  echo "-        <compilerarg value=\"-g\" if=\"jni.debug\"/>" >> ${PATCHFILE}
  for x in $CFLAGS; do
    echo "+        <compilerarg value=\"$x\"/>" >> ${PATCHFILE}
    counter=$((counter+1))
  done
  echo "         <compilerarg value=\"-Wall\"/>" >> ${PATCHFILE}
  echo "         <compilerarg value=\"-Werror\" if=\"jni.werror\"/>" >> ${PATCHFILE}
  echo "         <compilerarg value=\"\${jni.gccm}\" if=\"jni.gccm\"/>" >> ${PATCHFILE}
  sed -i "s/${REPLACESTRING}/$counter/g" ${PATCHFILE} || die
  patch -p1 < ${PATCHFILE} || die

  # Can be improved to fit the Gentoo way. Problem with using eant and JAVA_ANT_REWRITE_CLASSPATH is
  # that jni-build.xml fails to be imported correctly, leading to build failure. 
  export CLASSPATH="`java-config -r`:`java-config -d --classpath ant-core,cpptasks`"
  ant -f ${EANT_BUILD_XML} -lib ${CLASSPATH} || die
}

src_install() {
  java-pkg_dojar "${S}/bindings/java/sigar-bin/lib/sigar.jar"
  java-pkg_doso "${S}/bindings/java/sigar-bin/lib/libsigar-amd64-linux.so"
  #mkdir -p "${D}/usr/share"
  #cp -R "${S}/bindings/java/sigar-bin" "${D}/usr/share/"
  #chmod +x "${D}/usr/share/sigar-bin/lib/libsigar-amd64-linux.so"
}
