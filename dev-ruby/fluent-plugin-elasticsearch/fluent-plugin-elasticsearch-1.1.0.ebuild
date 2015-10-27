# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="ElasticSearch output plugin for Fluent event collector"
HOMEPAGE="https://rubygems.org/gems/fluent-plugin-elasticsearch"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=app-admin/fluentd-0.10.43"
ruby_add_rdepend ">=dev-ruby/elasticsearch-0"
ruby_add_rdepend ">=dev-ruby/excon-0"
