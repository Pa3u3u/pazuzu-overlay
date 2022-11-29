# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A very simple, rounded, sans serif family"
HOMEPAGE="https://github.com/impallari/Dosis"
SRC_URI="https://github.com/impallari/Dosis"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/impallari/Dosis"
EGIT_COMMIT="f59c9a42a8b5c7b1b240c37a35cba8f140286b81"

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
		FONT_S="${WORKDIR}/${P}/fonts/v1007 Fontlab - Original/${font_type_uc}" \
			FONT_SUFFIX=${font_type} \
			font_src_install
	done
}
