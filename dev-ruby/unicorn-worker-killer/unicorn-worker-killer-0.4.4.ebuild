# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="Kill unicorn workers by memory and request counts"
HOMEPAGE="https://github.com/kzk/unicorn-worker-killer"

LICENSE="GPL-3 GPL-2 Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/get_process_mem"
ruby_add_rdepend ">=dev-ruby/unicorn-4"
ruby_add_rdepend "!>=dev-ruby/unicorn-6"
