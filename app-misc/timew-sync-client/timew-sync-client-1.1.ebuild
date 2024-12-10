# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Timewarrior Sync client"
HOMEPAGE="
	https://pypi.org/project/timewsync/
"

RDEPEND="
	>=dev-python/colorama-0.4.6
	>=dev-python/jwcrypto-1.5.6
	>=dev-python/pyjwt-2.9.0
	>=dev-python/requests-2.32.3
"

SRC_URI="$(pypi_sdist_url "timewsync" "${PV}")"
S="${WORKDIR}/timewsync-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
