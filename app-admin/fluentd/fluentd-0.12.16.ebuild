# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="an open source data collector designed to scale and simplify log management."
HOMEPAGE="https://rubygems.org/gems/fluentd"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/coolio-1.2.2"
ruby_add_rdepend "!>=dev-ruby/coolio-2.0.0"
ruby_add_rdepend ">=dev-ruby/http_parser_rb-0.5.1"
ruby_add_rdepend "!>=dev-ruby/http_parser_rb-0.7.0"
ruby_add_rdepend ">=dev-ruby/json-1.4.3"
ruby_add_rdepend ">=dev-ruby/msgpack-0.5.11"
ruby_add_rdepend "!>=dev-ruby/msgpack-0.6.0"
ruby_add_rdepend ">=dev-ruby/sigdump-0.2.2"
ruby_add_rdepend "!>=dev-ruby/sigdump-1.0.0"
ruby_add_rdepend ">=dev-ruby/string-scrub-0.0.3"
ruby_add_rdepend ">=dev-ruby/tzinfo-1.0.0"
ruby_add_rdepend ">=dev-ruby/tzinfo-data-1.0.0"
ruby_add_rdepend ">=dev-ruby/yajl-ruby-1.0.0"
ruby_add_rdepend "!>=dev-ruby/yajl-ruby-2.0.0"
