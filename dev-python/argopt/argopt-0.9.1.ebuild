# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Documentation to argparse given by docopt"
HOMEPAGE="
	https://pypi.org/project/argopt/
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
