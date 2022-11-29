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

src_install() {
	elog "Installing otf font"

	# Yes, there is literally a space at the end of the directory name.
	FONT_S="${WORKDIR}/${P}/fonts/v2007 - Glyph migration and Viet extension " \
		FONT_SUFFIX=otf \
		font_src_install
}
