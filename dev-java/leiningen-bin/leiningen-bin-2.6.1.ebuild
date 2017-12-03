# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit java-pkg-2 bash-completion-r1

MY_P="leiningen-${PV}"

DESCRIPTION="Automating Clojure projects without setting your hair on fire"
HOMEPAGE="http://leiningen.org/"
SRC_URI="https://github.com/technomancy/leiningen/releases/download/${PV}/${MY_P}-standalone.zip -> ${MY_P}-standalone.jar
	https://github.com/technomancy/leiningen/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

COMMON_DEP="!dev-java/leiningen"

RDEPEND=">=virtual/jre-1.7
	dev-lang/clojure
	${COMMON_DEP}"
DEPEND="${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	sed -i \
		-e "s|^LEIN_JAR=.*|LEIN_JAR=${EROOT}/usr/share/leiningen-bin/lib/leiningen-standalone.jar|" \
		bin/lein-pkg || die
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${MY_P}-standalone.jar" leiningen-standalone.jar
	newbin bin/lein-pkg lein
	doman doc/lein.1
	dodoc doc/*.md *.md
	newbashcomp bash_completion.bash leiningen
}
