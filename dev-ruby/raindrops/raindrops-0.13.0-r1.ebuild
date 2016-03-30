# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby21 ruby22 ruby23"

inherit ruby-fakegem

DESCRIPTION="real-time stats toolkit for Rack HTTP servers"
HOMEPAGE="https://rubygems.org/gems/raindrops"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/rack"

# The following with credit to Edward Middleton for the original work
# @ https://github.com/emiddleton/chef-gentoo-bootstrap-overlay

each_ruby_configure() {
    ${RUBY} -Cext/raindrops extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext/raindrops || die "emake failed"
	cp ext/raindrops/raindrops_ext.so lib/ || die
}
