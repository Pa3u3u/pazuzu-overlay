# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Confetti (or fireworks) inside your terminal"
HOMEPAGE="https://github.com/maaslalani/confetty"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

go_name="github.com/maaslalani/confetty"
base_uri="https://${go_name}"

inherit go-module git-r3
EGIT_REPO_URI="${base_uri}"

case "${PV}" in
	230423)
		EGIT_COMMIT="6c6f1b5b"
		;;
	999999)
		;;
	*)
		die "Unknown revision '${PV}'"
esac

SRC_URI="https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz"

src_unpack() {
	git-r3_src_unpack
	go-module_src_unpack
}

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
}
