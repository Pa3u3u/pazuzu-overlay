# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Original source:
# https://data.gpo.zugaina.org/guru/x11-misc/gromit-mpx/gromit-mpx-9999.ebuild

EAPI=8

inherit cmake xdg

DESCRIPTION="Gromit-MPX is a multi-pointer GTK3 port of the Gromit desktop annotation tool"
HOMEPAGE="https://github.com/bk138/gromit-mpx"

SRC_URI="https://github.com/bk138/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 x86"

RDEPEND="
	x11-libs/gtk+:3
	>=dev-libs/libayatana-appindicator-0.5
	x11-libs/libX11
	>=x11-apps/xinput-1.3
"
DEPEND="${RDEPEND}"

src_prepare () {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}"/etc
	)

	cmake_src_configure
}
