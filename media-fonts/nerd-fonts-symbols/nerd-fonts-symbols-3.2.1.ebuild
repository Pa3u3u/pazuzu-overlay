# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Inspired by amano-kenji/nerd-fonts-symbols, without modifying '$S'.

EAPI=8

inherit font

DESCRIPTION="Nerd Fonts, symbols-only variant"
HOMEPAGE="https://nerdfonts.com"

SRC_URI="
	"https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/NerdFontsSymbolsOnly.tar.xz" \
		-> "NerdFontsSymbolsOnly-${PV}.tar.xz"
	"https://github.com/ryanoasis/nerd-fonts/raw/v${PV}/10-nerd-font-symbols.conf" \
		-> "10-nerd-font-symbols-${PV}.conf"
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/xz-utils"

src_unpack() {
	mkdir -p "$S"

	cp "${DISTDIR}/10-nerd-font-symbols-${PV}.conf" "$S/10-nerd-font-symbols.conf"
	tar -Jx -C "$S" -f "${DISTDIR}/NerdFontsSymbolsOnly-${PV}.tar.xz"
}

src_install() {
	find "$S" -iname 'readme.md' -delete

	FONT_SUFFIX="ttf"
	FONT_CONF=("${S}/10-nerd-font-symbols.conf")
	font_src_install
}
