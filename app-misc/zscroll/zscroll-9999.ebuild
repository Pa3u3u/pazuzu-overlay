# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A text scroller for panels or terminals"
HOMEPAGE="https://github.com/noctuid/zscroll"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-python/poetry-core
"
RDEPEND="${DEPEND}"
BDEPEND=""

PYTHON_COMPAT=( python3_{8,9,10,11} )

DISTUTILS_USE_PEP517=poetry
inherit git-r3 distutils-r1

distutils_enable_tests pytest

EGIT_REPO_URI="https://github.com/noctuid/zscroll"

if [ ${PV} != "9999" ]; then
	EGIT_COMMIT="${PV}"
fi
