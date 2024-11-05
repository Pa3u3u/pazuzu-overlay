# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pretty-print git repository collaborators sorted by contributions"
HOMEPAGE="
	https://pypi.org/project/git-fame/
"

RDEPEND="
	>=dev-python/argopt-0.8
	>=dev-python/tabulate-0.9
	>=dev-python/tqdm-4
"

SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"
S="${WORKDIR}/$(pypi_normalize_name ${PN})-${PV}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
