# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="Message forwarding over SSL with authentication"
HOMEPAGE="https://github.com/Home24/fluent-plugin-secure-forward"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=app-admin/fluentd-0.10.46"
ruby_add_rdepend ">=dev-ruby/fluent-mixin-config-placeholders-0.3.0"
ruby_add_rdepend "dev-ruby/proxifier"
ruby_add_rdepend "dev-ruby/resolve-hostname"
