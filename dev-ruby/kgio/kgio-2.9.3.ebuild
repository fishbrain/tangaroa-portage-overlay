# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="non-blocking I/O library for Ruby"
HOMEPAGE="https://rubygems.org/gems/kgio"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_configure() {
    ${RUBY} -Cext/kgio extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext/kgio || die "emake failed"
	cp ext/kgio/kgio_ext.so lib/ || die
}
