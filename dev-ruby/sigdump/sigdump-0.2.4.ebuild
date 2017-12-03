# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="Setup signal handler which dumps backtrace of running threads and number of allocated objects per class"
HOMEPAGE="https://rubygems.org/gems/sigdump"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
