# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Eucalyptus Drop is an enhanced fork of SDDM Sugar Candy by Marian Arlt"
HOMEPAGE="https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/"
SRC_URI="https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/-/archive/v${PV}/sddm-eucalyptus-drop-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	>=dev-qt/qt5compat-6.7
	>=dev-qt/qtgraphicaleffects-5.11
	>=dev-qt/qtquickcontrols2-5.11
	>=dev-qt/qtsvg-5.11
	>=x11-misc/sddm-0.18
"
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	mv "sddm-eucalyptus-drop-v${PV}" "${P}"
}

src_install() {
	insinto /usr/share/sddm/themes/eucalyptus-drop
	doins -r *
}
