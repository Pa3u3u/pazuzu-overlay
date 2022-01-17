# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Aleo is a contemporary typeface."
HOMEPAGE="https://github.com/AlessioLaiso/aleo"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND} "
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/AlessioLaiso/${PN}/"

if [[ ${PV} != "9999" ]]; then
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="${PV}"
fi

FONT_S="fonts/otf"
FONT_SUFFIX="otf"
