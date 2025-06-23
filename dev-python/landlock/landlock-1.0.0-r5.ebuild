# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Harden Python code with rule-based file system access restrictions"
HOMEPAGE="
	https://pypi.org/project/landlock/
"

MY_SUFFIX=".dev5"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" "$MY_SUFFIX.tar.gz")"
S="${WORKDIR}/${P}$MY_SUFFIX"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/flit-core-3.2
"

distutils_enable_tests pytest
