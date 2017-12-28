# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit java-pkg-2 user

DESCRIPTION="SonarQube is an open platform to manage code quality."
HOMEPAGE="http://sonarsource.org/"
LICENSE="LGPL-3"
MY_PV="${PV/_alpha/M}"
MY_PV="${MY_PV/_rc/-RC}"
MY_P="sonarqube-${MY_PV}"
SRC_URI="https://sonarsource.bintray.com/Distribution/sonarqube/${MY_P}.zip"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.8
	dev-java/java-service-wrapper"

INSTALL_DIR="/opt/sonar"

pkg_setup() {
	enewgroup sonar
	enewuser sonar -1 /bin/bash /opt/sonar "sonar"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TODO remove unneded files

	# Fix permissions
	chmod -R a-x,a+X conf data extensions lib temp web COPYING

	# Fix EOL in configuration files
	for i in conf/* ; do
		awk '{ sub("\r$", ""); print }' $i > $i.new
		mv $i.new $i
	done
}

src_prepare() {
	mkdir "${S}/libexec"
	cp "${S}"/bin/linux-x86-64/sonar.sh "${S}"/libexec || die
	epatch "${FILESDIR}"/sonar.sh.patch || die
	epatch "${FILESDIR}"/wrapper.conf.patch || die

	rm -r "${S}/lib/jsw" || die
}

src_install() {
	dosym /etc/sonar "${INSTALL_DIR}"/conf
	dosym /var/log/sonar "${INSTALL_DIR}"/logs
	dosym /var/lib/sonar/data "${INSTALL_DIR}"/data
	dosym /var/lib/sonar/temp "${INSTALL_DIR}"/temp
	dosym /var/lib/sonar/extensions "${INSTALL_DIR}"/extensions


	insinto /var/lib/sonar/extensions
	doins -r extensions/jdbc-driver
	doins -r extensions/plugins

	insinto "${INSTALL_DIR}"
	doins -r elasticsearch lib web COPYING

	exeinto /usr/libexec
	doexe libexec/sonar.sh

	insinto /etc/sonar
	doins conf/wrapper.conf
	doins conf/sonar.properties

	
	newinitd "${FILESDIR}"/sonar.initd sonar
	newconfd "${FILESDIR}"/sonar.confd sonar

	mkdir -p "${D}"/var/lib/sonar/data
	mkdir -p "${D}"/var/lib/sonar/temp
	mkdir -p "${D}"/var/log/sonar

	fowners -R sonar:sonar "${INSTALL_DIR}"
	fowners -R sonar:sonar /var/lib/sonar
	fowners -R sonar:root /var/log/sonar
	fowners -R root:sonar /etc/sonar

	fperms -R 750 /var/lib/sonar
	fperms -R 770 /var/log/sonar
	fperms -R 750 /etc/sonar

	fperms 755 "${INSTALL_DIR}/elasticsearch/bin/elasticsearch"
	fperms 755 "${INSTALL_DIR}/elasticsearch/bin/elasticsearch.in.sh"
	fperms 755 "${INSTALL_DIR}/elasticsearch/bin/elasticsearch-keystore"
	fperms 755 "${INSTALL_DIR}/elasticsearch/bin/elasticsearch-plugin"
	fperms 755 "${INSTALL_DIR}/elasticsearch/bin/elasticsearch-translog"


	keepdir /etc/sonar
	keepdir /var/lib/sonar
	keepdir /var/log/sonar
}
