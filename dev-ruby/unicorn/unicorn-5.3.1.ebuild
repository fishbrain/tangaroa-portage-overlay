# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="low-latency, high bandwidth Rack HTTP server"
HOMEPAGE="https://rubygems.org/gems/unicorn"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/bundler"
ruby_add_rdepend ">=dev-ruby/kgio-2.6"
ruby_add_rdepend ">=dev-ruby/raindrops-0.7"

# The following with credit to Edward Middleton for the original work
# @ https://github.com/emiddleton/chef-gentoo-bootstrap-overlay

each_ruby_configure() {
    ${RUBY} -Cext/unicorn_http extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext/unicorn_http || die "emake failed"
	cp ext/unicorn_http/unicorn_http.so lib/ || die
}

all_ruby_install() {
	all_fakegem_install

	newinitd "${FILESDIR}"/unicorn.initd unicorn
	newconfd "${FILESDIR}"/unicorn.confd unicorn
}
