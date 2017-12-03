# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem user

DESCRIPTION="an open source data collector designed to scale and simplify log management."
HOMEPAGE="https://rubygems.org/gems/fluentd"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	enewgroup fluentd
	enewuser fluentd -1 -1 -1 fluentd
}

src_install() {
	ruby-ng_src_install
	newinitd ${FILESDIR}/fluentd.initd-r1 fluentd
	newconfd ${FILESDIR}/fluentd.confd fluentd
}

ruby_add_rdepend ">=dev-ruby/coolio-1.4.5"
ruby_add_rdepend "!>=dev-ruby/coolio-2.0.0"
ruby_add_rdepend ">=dev-ruby/http_parser_rb-0.5.1"
ruby_add_rdepend "!>=dev-ruby/http_parser_rb-0.7.0"
ruby_add_rdepend ">=dev-ruby/json-1.4.3"
ruby_add_rdepend ">=dev-ruby/msgpack-0.7.0"
ruby_add_rdepend "!>=dev-ruby/msgpack-2.0.0"
ruby_add_rdepend ">=dev-ruby/serverengine-2.0.4"
ruby_add_rdepend "!>=dev-ruby/serverengine-3.0.0"
ruby_add_rdepend ">=dev-ruby/sigdump-0.2.2"
ruby_add_rdepend "!>=dev-ruby/sigdump-0.3.0"
ruby_add_rdepend ">=dev-ruby/strptime-0.1.7"
ruby_add_rdepend "!>=dev-ruby/strptime-0.2.0"
ruby_add_rdepend ">=dev-ruby/tzinfo-1.0.0"
ruby_add_rdepend "!>=dev-ruby/tzinfo-2.0.0"
ruby_add_rdepend ">=dev-ruby/tzinfo-data-1.0.0"
ruby_add_rdepend "!>=dev-ruby/tzinfo-data-2.0.0"
ruby_add_rdepend ">=dev-ruby/yajl-ruby-1.0.0"
ruby_add_rdepend "!>=dev-ruby/yajl-ruby-2.0.0"
