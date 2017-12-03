# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="TZInfo::Data contains data from the IANA Time Zone database packaged as Ruby modules for use with TZInfo."
HOMEPAGE="https://rubygems.org/gems/tzinfo-data"

LICENSE="GPL-2+ Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/tzinfo-1.0.0"
