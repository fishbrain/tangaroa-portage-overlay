# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="to add various placeholders for plugin configurations"
HOMEPAGE="https://github.com/tagomoris/fluent-mixin-config-placeholders"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "app-admin/fluentd"
ruby_add_rdepend ">=dev-ruby/uuidtools-2.1.5"
