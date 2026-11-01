# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A flock of birds in your terminal"
HOMEPAGE="https://github.com/clainstone/cbirds"
SRC_URI="
	https://github.com/clainstone/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin cbirds
}
