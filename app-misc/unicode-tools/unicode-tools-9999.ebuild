# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Unicode character identification and other tools"
HOMEPAGE="https://gitlab.fi.muni.cz/xlacko1/unicode-tools"

LICENSE="WTFPL-2"
SLOT="0"

script_iuse_flags="
	+unicode
	unifont"

IUSE="
	${script_iuse_flags}
	doc"

DEPEND=""
RDEPEND="
	>=dev-lang/perl-5.30
	${DEPEND}"
BDEPEND=""

REQUIRED_USE="|| ( unicode unifont )"

inherit git-r3

EGIT_REPO_URI="https://gitlab.fi.muni.cz/xlacko1/unicode-tools/"

if [ ${PV} != "9999" ]; then
	EGIT_COMMIT="v${PV}"
fi

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
