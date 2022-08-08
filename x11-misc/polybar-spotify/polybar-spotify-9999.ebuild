# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Polybar module for showing currently played song"
HOMEPAGE="https://github.com/PrayagS/polybar-spotify"
SRC_URI="https://github.com/PrayagS/polybar-spotify"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	app-misc/zscroll
	x11-misc/polybar[ipc]
"

RDEPEND="${DEPEND}"
BDEPEND=""

inherit git-r3

EGIT_REPO_URI="${SRC_URI}"

src_prepare() {
	eapply_user

	mv get_spotify_status.sh polybar-spotify-status
	mv scroll_spotify_status.sh polybar-spotify-scroll
}

src_install() {
	dobin polybar-spotify-status
	dobin polybar-spotify-scroll
	dodoc README.md
}

post_install() {
	elog "Scripts were renamed to"
	elog "  polybar-spotify-status"
	elog "  polybar-spotify-scroll"
}
