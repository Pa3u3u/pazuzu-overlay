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
	doc? ( || ( app-text/ronn app-text/ronn-ng ) )"

inherit git-r3

EGIT_REPO_URI="https://gitlab.fi.muni.cz/xlacko1/remind/"

if [ ${PV} != "9999" ]; then
	EGIT_COMMIT="v${PV}"
fi

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
