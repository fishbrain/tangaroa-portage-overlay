# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="Ruby client for Elasticsearch. See the 'elasticsearch' gem for full integration."
HOMEPAGE="https://rubygems.org/gems/elasticsearch-transport"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/faraday"
ruby_add_rdepend "dev-ruby/multi_json"
