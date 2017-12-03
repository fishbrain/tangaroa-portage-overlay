# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="A framework to implement robust multiprocess servers like Unicorn"
HOMEPAGE="https://rubygems.org/gems/serverengine"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/sigdump-0.2.2"
