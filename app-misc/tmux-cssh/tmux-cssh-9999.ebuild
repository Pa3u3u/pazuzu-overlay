# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Spawns multiple synchronized SSH sessions inside a tmux session"
HOMEPAGE="https://github.com/peikk0/tmux-cssh"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	>=app-misc/tmux-1.1"
BDEPEND="
	app-arch/zip"

base_uri="https://github.com/peikk0/${PN}"

case "${PV}" in
	9999)
		inherit git-r3
		EGIT_REPO_URI="${base_uri}"
		;;
	*)
		KEYWORDS="~amd64 ~x86"
		SRC_URI="${base_uri}/${PN}/archive/master.zip -> ${P}.zip"
		;;
esac

src_install() {
	dobin ${PN}
	dodoc README.md
}
