# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild was taken from GURU repository and modified
# https://wiki.gentoo.org/wiki/Project:GURU

EAPI=8

DESCRIPTION="Asciiquarium is an aquarium/sea animation in ASCII art"
HOMEPAGE="
	https://robobunny.com/projects/asciiquarium/html/
	https://github.com/cmatsuoka/asciiquarium
"

COMMIT="8bdb7d441a36a5a9f64b853317a66f9d4a82f08f"
SRC_URI="https://github.com/cmatsuoka/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	=dev-perl/Term-Animation-2*
"

RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="
	kirk-objects
	yellow-submarine
	sword-fish
"

# If kirk-objects is set, yellow-submarine will not work
REQUIRED_USE="kirk-objects? ( !yellow-submarine )"

PATCHES=()

src_prepare() {
	for flag in ${IUSE}; do
		if use "${flag}"; then
			PATCHES+=( "${FILESDIR}/${flag}.patch" )
		fi
	done

	default
}

src_install() {
	dobin asciiquarium
	einstalldocs
}
