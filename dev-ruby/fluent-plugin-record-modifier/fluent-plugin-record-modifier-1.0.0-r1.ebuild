# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="fluentd plugin to edit record in-flight"
HOMEPAGE="https://github.com/tagomoris/fluent-plugin-modifier"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=app-admin/fluentd-0.14"

src_prepare() {
  epatch "${FILESDIR}"/encoding_type_errors.patch
  default
}
