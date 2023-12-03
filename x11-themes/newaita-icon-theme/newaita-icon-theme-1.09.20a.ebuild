# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Original source:
# https://github.com/linxon/gentoo-overlay/blob/master/x11-themes/newaita-icon-theme/newaita-icon-theme-20181004.ebuild

EAPI=8

MY_PN="Newaita"

inherit xdg

DESCRIPTION="Linux icon theme combining old style and color of material design"
HOMEPAGE="https://github.com/cbrnix/Newaita"
SRC_URI=""

KEYWORDS="amd64 x86"
SRC_URI="https://github.com/cbrnix/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"
LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"
IUSE="
	+light
	+dark
"

REQUIRED_USE="|| ( light dark )"

src_unpack() {
	default
	mv "${WORKDIR}/${MY_PN}-${PV}" "${WORKDIR}/${P}" || die
}

src_prepare() {
	default

	mv "${S}"/Newaita-dark "${S}"/Newaita-Dark || die
	rm -fv "${S}"/Newaita{,-Dark}/{FV.sh,PV.sh,README.md,License-*} || die
}

src_install() {
	insinto "/usr/share/icons"

	use light \
		&& doins -r Newaita

	use dark \
		&& doins -r Newaita-Dark

	dodoc README.md
}
