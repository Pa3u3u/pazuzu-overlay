# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module

DESCRIPTION="Timewarrior Synchronisation server"
HOMEPAGE="https://github.com/timewarrior-synchronize/timew-sync-server"
SRC_URI="
	https://github.com/timewarrior-synchronize/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.22"

PATCHES=(
	"${FILESDIR}/paths.patch"
)

IUSE="systemd"

src_unpack() {
	default
	cp "${FILESDIR}/${P}.service" "$S/${PN}.service"
}

src_compile() {
	ego build
}

src_install() {
	dobin timew-sync-server

	if use systemd; then
		systemd_dounit timew-sync-server.service
	fi

	default
}
