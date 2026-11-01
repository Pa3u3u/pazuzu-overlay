# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Retrieve the fabled Amulet of Yendor from the 26th level"
HOMEPAGE="https://github.com/tmewett/BrogueCE"
SRC_URI="
	https://github.com/tmewett/BrogueCE/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=media-libs/libsdl2-2.0.0
	>=media-libs/sdl2-image-2.0.0
"

DATADIR="/usr/share/brogue"

src_unpack() {
	default_src_unpack
	mv "BrogueCE-${PV}" "$P"
}

src_compile() {
	emake DATADIR="${EPREFIX}${DATADIR}"
}

src_install() {
	dobin bin/brogue

	insinto "${DATADIR}"
	doins -r bin/assets
	doins bin/keymap.txt
}
