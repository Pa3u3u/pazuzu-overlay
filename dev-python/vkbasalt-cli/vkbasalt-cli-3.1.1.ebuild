# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="CLI utility and library in conjunction with vkBasalt"
HOMEPAGE="
	https://pypi.org/project/vkbasalt-cli/
"

MY_SUFFIX=".post2"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" "$MY_SUFFIX.tar.gz")"
S="${WORKDIR}/${P}$MY_SUFFIX"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-gfx/vkBasalt"
BDEPEND=""

distutils_enable_tests pytest
