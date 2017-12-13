# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GOLANG_PKG_IMPORTPATH="github.com/${PN}io"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_IS_MULTIPLE=1
GOLANG_PKG_HAVE_TEST=1

# Declare dependencies
GOLANG_PKG_DEPENDENCIES=(
	"github.com/BurntSushi/toml:2dff11163ee667d51dcc066660925a92ce138deb"
	"github.com/bitly/go-hostpool:58b95b10d6ca26723a7f46017b348653b825a8d6"
	"github.com/nsqio/go-nsq:642a3f9935f12cb3b747294318d730f56f4c34b4"
	"github.com/bitly/go-simplejson:18db6e68d8fd9cbf2e8ebe4c81a78b96fd9bf05a"
	"github.com/bmizerany/perks:6cb9d9d729303ee2628580d9aec5db968da3a607"
	"github.com/mreiferson/go-options:7ae3226d3e1fa6a0548f73089c72c96c141f3b95"
	"github.com/mreiferson/go-snappystream:028eae7ab5c4c9e2d1cb4c4ca1e53259bbe7e504"
	"github.com/bitly/timer_metrics:afad1794bb13e2a094720aeb27c088aa64564895"
	"github.com/blang/semver:9bf7bff48b0388cb75991e58c6df7d13e982f1f2"
	"github.com/julienschmidt/httprouter:6aacfd5ab513e34f7e64ea9627ab9670371b34e7"
	"github.com/judwhite/go-svc:63c12402f579f0bdf022653c821a1aa5d7544f01"
)

inherit golang-single

DESCRIPTION="A real-time distributed messaging platform, written in GoLang"
HOMEPAGE="http://nsq.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND="dev-libs/protobuf:0/9"

src_test() {
	if has sandbox $FEATURES && has usersandbox $FEATURES; then
		eerror "Tests require sandbox, and usersandbox to be disabled in FEATURES."
	fi

	golang-single_src_test
}
