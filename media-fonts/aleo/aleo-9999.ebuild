# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A readable font with semi-rounded details and sleek structure"
HOMEPAGE="https://github.com/AlessioLaiso/aleo"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND} "
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/AlessioLaiso/${PN}/"

if [ ${PV} != "9999" ]; then
	EGIT_COMMIT="${PV}"
fi

FONT_S="fonts/otf"
FONT_SUFFIX="otf"
