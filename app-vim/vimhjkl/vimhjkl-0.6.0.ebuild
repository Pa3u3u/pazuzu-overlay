# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11..15} )
inherit distutils-r1

DESCRIPTION="Drill the Vim techniques vimtutor skips, in real vim"
HOMEPAGE="https://github.com/S-Sigdel/vimhjkl"
SRC_URI="https://github.com/S-Sigdel/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	|| ( app-editors/vim app-editors/neovim )
"

distutils_enable_tests pytest
