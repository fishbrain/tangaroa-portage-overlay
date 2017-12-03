# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="Re-emmit a record with rewrited tag when a value matches/unmatches with the regular expression."
HOMEPAGE="https://github.com/fluent/fluent-plugin-rewrite-tag-filter"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "app-admin/fluentd"
