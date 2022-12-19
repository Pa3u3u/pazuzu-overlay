# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A versatile sans family"
HOMEPAGE="https://github.com/impallari/Encode-Sans"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit font git-r3

EGIT_REPO_URI="https://github.com/impallari/Encode-Sans"
EGIT_COMMIT="370cdccdb22daf862c6fca0636aad64b6835decd"

src_install() {
	elog "Installing ttf font"

	FONT_S="${WORKDIR}/${P}/fonts/" \
		FONT_SUFFIX=ttf \
		font_src_install
}
