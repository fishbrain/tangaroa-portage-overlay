# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="a fast strptime engine which uses VM."
HOMEPAGE="https://rubygems.org/gems/strptime"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_configure() {
    ${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
    emake V=1 -Cext/${PN}
    cp ext/${PN}/${PN}.so lib/strptime/ || die
}
