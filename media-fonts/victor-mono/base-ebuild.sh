# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="An open-source monospaced font with optional semi-connected cursive italics"
HOMEPAGE="https://rubjo.github.io/victor-mono/"

LICENSE="OFL"
SLOT="0"

KEYWORDS="amd64 arm64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

inherit font

base_uri="https://github.com/rubjo/victor-mono"

SRC_URI="${base_uri}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

font_iuse_flags="
	+otf
	+ttf
	eot
	woff
	woff2"

IUSE="${font_iuse_flags}"

REQUIRED_USE="|| ( ttf otf )"

src_unpack() {
	default_src_unpack

	cd "${WORKDIR}"
	mv "${P}/public/VictorMonoAll.zip" "."
	unzip VictorMonoAll.zip
}

src_install() {
	for font_flag in ${font_iuse_flags}; do
		font_type=$(echo ${font_flag} | tr -d '+-')

		if ! use ${font_type}; then
			continue
		fi

		elog "Installing ${font_type} font"

		font_type_uc=$(echo ${font_type} | tr 'a-z' 'A-Z')

		FONT_S="${WORKDIR}/${font_type_uc}" FONT_SUFFIX=${font_type} font_src_install
	done
}
