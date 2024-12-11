# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Start lock and unlock user targets when system is locked or unlocked"
HOMEPAGE="https://git.sr.ht/~whynothugo/systemd-lock-handler"

inherit git-r3 go-module

EGIT_REPO_URI="https://git.sr.ht/~whynothugo/systemd-lock-handler"
EGIT_COMMIT="v${PV}"
SRC_URI="https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz"

LICENSE="ISC"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.16"

src_unpack() {
	git-r3_src_unpack
	go-module_src_unpack
	default
}

src_compile() {
	ego build
}
