# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

EGIT_REPO_URI="git://github.com/fluent/${PN}.git"
EGIT_BRANCH="master"
EGIT_COMMIT="f1e06b2e9a5a7a81b48447a60f7dbb613484415b"


inherit ruby-fakegem
SRC_URI=""

inherit git-r3

DESCRIPTION="Re-emmit a record with rewrited tag when a value matches/unmatches with the regular expression."
HOMEPAGE="https://github.com/fluent/fluent-plugin-rewrite-tag-filter"

LICENSE="Apache-2.0"
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

ruby_add_rdepend ">=app-admin/fluentd-0.14.2"
