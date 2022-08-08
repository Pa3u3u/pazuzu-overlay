# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Material Design icons by Google"
HOMEPAGE="https://github.com/google/material-design-icons"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="
	+otf
	+ttf
"

REQUIRED_USE="|| ( ttf otf )"

inherit font

if [ "${PV}" == 9999 ]; then
	EGIT_REPO_URI="https://github.com/google/material-design-icons"
	# Build directory for this package can easily reach > 10 GiB. We will try
	# to limit the size by using shallow clone.
	EGIT_MIN_CLONE_TYPE="shallow"
	inherit git-r3
else
	SRC_URI="
		https://github.com/google/material-design-icons/archive/refs/tags/${PV}.tar.gz
			-> ${P}.tar.gz
	"
fi

src_install() {
	for font_type in otf ttf; do
		if ! use ${font_type}; then
			continue
		fi

		elog "Installing ${font_type} font"

		FONT_S="${S}/font" FONT_SUFFIX=${font_type} font_src_install
	done
}
