# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An elegant sans-serif typeface family"
HOMEPAGE="https://github.com/impallari/Raleway"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/impallari/Raleway"
EGIT_COMMIT="6c67ab1f7aa65c442bd2745bb9d4ef1cd7bc01fa"

src_install() {
	elog "Installing otf font"

	FONT_S="${WORKDIR}/${P}/fonts/v$(ver_rs 1- '')" \
		FONT_SUFFIX=otf \
		font_src_install
}
