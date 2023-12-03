# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A cross-platform color picker"
HOMEPAGE="https://github.com/nielssp/colorgrab"

LICENSE="MIT"
SLOT="0"

DEPEND="
	>=x11-libs/wxGTK-3.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	=dev-util/cmake-3*
"

SRC_URI="https://github.com/nielssp/colorgrab/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"
PATCHES+=( "${FILESDIR}/wxgtk3.patch" )

inherit cmake desktop xdg-utils

src_install() {
	dobin "${BUILD_DIR}/colorgrab"
	domenu "${S}/pkg/arch/colorgrab.desktop"
}

pkg_postinst() {
	xdg_desktop_database_update
}
