# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="Ruby integrations for Elasticsearch (client, API, etc.)"
HOMEPAGE="https://rubygems.org/gems/elasticsearch"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "=dev-ruby/elasticsearch-api-1.0.14"
ruby_add_rdepend "=dev-ruby/elasticsearch-transport-1.0.14"
