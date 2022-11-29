# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A humanist sans font"
HOMEPAGE="https://github.com/impallari/Cabin"
SRC_URI="https://github.com/impallari/Cabin"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/impallari/Cabin"
EGIT_COMMIT="70efa8c3179359cc50b01ca184fec8a694156140"

IUSE="
	+otf
	+ttf
"

REQUIRED_USE="|| ( ttf otf )"

src_install() {
	for font_type in ttf otf; do
		if ! use ${font_type}; then
			continue
		fi

		elog "Installing ${font_type} font"
		font_type_uc=$(echo ${font_type} | tr 'a-z' 'A-Z')
		FONT_S="${WORKDIR}/${P}/fonts/${font_type_uc}" \
			FONT_SUFFIX=${font_type} \
			font_src_install
	done
}
