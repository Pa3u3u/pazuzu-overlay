# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Convenient keyboard layout for writing both Slovak and code"
HOMEPAGE="https://github.com/jergusg/SK-Prog-Keyboard"
SRC_URI="https://github.com/jergusg/SK-Prog-Keyboard/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-base/xorg-server
	x11-misc/xkeyboard-config
"
RDEPEND="${DEPEND}"

PATCHES+=(
	"${FILESDIR}/include-latin.patch"
)

src_unpack() {
	default
	mv "SK-Prog-Keyboard-${PV}" "${P}" || die
}

src_install() {
	insinto "/usr/share/X11/xkb/symbols"
	newins "linux/sk-prog" "sk-prog"
}
