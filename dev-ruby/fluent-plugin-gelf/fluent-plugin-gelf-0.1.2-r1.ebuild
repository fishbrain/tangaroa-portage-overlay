# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

EGIT_REPO_URI="git://github.com/emsearcy/${PN}.git"
EGIT_COMMIT="027416757aca42e98b2e21bc8dec829b25a57e44"

inherit ruby-fakegem
SRC_URI=""

inherit git-r3

DESCRIPTION="Gelf output plugin for fluentd"
HOMEPAGE="https://github.com/emsearcy/fluent-plugin-gelf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
  git-r3_src_unpack
  mkdir "${S}/all"
  einfo $S
  einfo $P
  mv "${S}/${P}" "${S}/all"
}

ruby_add_rdepend ">=dev-ruby/gelf-2.0.0"
