# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="TZInfo::Data contains data from the IANA Time Zone database packaged as Ruby modules for use with TZInfo."
HOMEPAGE="https://rubygems.org/gems/tzinfo-data"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/tzinfo-1.0.0"
