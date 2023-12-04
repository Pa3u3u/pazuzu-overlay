# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Desktop notifications and reminders"
HOMEPAGE="https://gitlab.fi.muni.cz/xlacko1/remind"

LICENSE="WTFPL-2"
SLOT="0"

IUSE="
	doc"

DEPEND="
	sys-process/at
	x11-libs/libnotify"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/bzip2
	doc? ( app-text/ronn-ng )"

KEYWORDS="amd64 x86"

MY_P="${PN}-v${PV}"

SRC_URI="https://gitlab.fi.muni.cz/xlacko1/remind/-/archive/v${PV}/${MY_P}.tar.bz2 -> ${P}.tar.gz"

src_unpack() {
	default
	mv "${MY_P}" "${P}" || die
}

src_compile() {
	default

	if use doc; then
		ronn "${WORKDIR}/${P}/man/"*.ronn
	fi
}

src_install() {
	dobin remind

	if use doc; then
		doman "${WORKDIR}/${P}/man/remind.1"
	fi
}
