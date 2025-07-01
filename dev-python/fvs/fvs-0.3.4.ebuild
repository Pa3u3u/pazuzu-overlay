# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="File Versioning System with hash comparison and data storage"
HOMEPAGE="
	https://pypi.org/project/fvs/
"

SRC_URI="$(pypi_sdist_url --no-normalize "${PN^^}" "${PV}")"
S="${WORKDIR}/${P^^}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest
