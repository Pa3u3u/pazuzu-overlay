# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Unicode character identification and other tools"
HOMEPAGE="https://gitlab.fi.muni.cz/xlacko1/unicode-tools"

LICENSE="WTFPL-2"
SLOT="0"

script_iuse_flags="
	+unicode
	unifont
	u8str
"

IUSE="
	${script_iuse_flags}
	doc"

DEPEND=""
RDEPEND="
	>=dev-lang/perl-5.36
	${DEPEND}"
BDEPEND=""

REQUIRED_USE="|| ( unicode unifont u8str )"

KEYWORDS="amd64 x86"
SRC_URI="https://gitlab.fi.muni.cz/xlacko1/${PN}/-/archive/v${PV}/${PN}-v${P}.tar.bz2 -> ${P}.tar.bz2"

src_unpack() {
	default
	mv "${PN}-v${PV}"-* "${S}" || die
}

src_compile() {
	default

	if use doc; then
		for script_flag in ${script_iuse_flags}; do
			script=$(echo ${script_flag} | tr -d '+-')

			if ! use ${script}; then
				continue
			fi

			pod2man --utf8 "${WORKDIR}/${P}/${script}" >"${WORKDIR}/${P}/${script}.1"
		done
	fi
}

src_install() {
	for script_flag in ${script_iuse_flags}; do
		script=$(echo ${script_flag} | tr -d '+-')

		if ! use ${script}; then
			continue
		fi

		dobin "${WORKDIR}/${P}/${script}"

		if use doc; then
			doman "${WORKDIR}/${P}/${script}.1"
		fi
	done
}
