# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A sweet theme for SDDM from Sugar series"
HOMEPAGE="https://github.com/Kangie/sddm-sugar-candy"
SRC_URI="https://github.com/Kangie/sddm-sugar-candy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=x11-misc/sddm-0.15"

src_unpack() {
	default_src_unpack
	mv "sddm-sugar-candy-${PV}" "${P}"
}

src_install() {
	insinto /usr/share/sddm/themes/sugar-candy
	doins -r *
}
