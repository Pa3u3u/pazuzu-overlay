# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An elegant sans-serif typeface family"
HOMEPAGE="https://github.com/impallari/Raleway"
SRC_URI="https://github.com/impallari/Raleway"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/impallari/Raleway"
EGIT_COMMIT="6c67ab1f7aa65c442bd2745bb9d4ef1cd7bc01fa"

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
		FONT_S="${WORKDIR}/${P}/fonts/v3.000 Fontlab/${font_type_uc}" \
			FONT_SUFFIX=${font_type} \
			font_src_install
	done
}
