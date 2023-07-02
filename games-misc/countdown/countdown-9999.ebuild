# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminal countdown timer"
HOMEPAGE="https://github.com/antonmedv/countdown"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.20"

go_name="github.com/antonmedv/countdown"
base_uri="https://${go_name}"

inherit go-module

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="${base_uri}"
else
	SRC_URI="${base_uri}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SRC_URI+=" https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz"

src_unpack() {
	if [ "${PV}" = 9999 ]; then
		git-r3_src_unpack
	fi

	go-module_src_unpack
}

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
}
