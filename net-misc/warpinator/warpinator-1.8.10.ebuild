# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit gnome2-utils linux-info meson python-r1 xdg

DESCRIPTION="Send and receive files across a local network"
HOMEPAGE="https://warpinator.com/"
SRC_URI="https://github.com/linuxmint/warpinator/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
	+landlock
"

DEPEND="
	>=dev-lang/python-3
	dev-python/async-timeout
	dev-python/cryptography
	>=dev-python/grpcio-1.16
	dev-python/ifaddr
	dev-python/netaddr
	dev-python/netifaces
	dev-python/protobuf
	>=dev-python/python3-xapp-1.6
	dev-python/qrcode
	dev-python/setproctitle
	>=dev-python/zeroconf-0.27
	x11-libs/xapp[introspection]

	landlock? ( dev-python/landlock )
	!landlock? ( sys-apps/bubblewrap )
"

RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

BDEPEND="
	dev-build/meson
	dev-build/ninja
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

EMESON_BUILDTYPE="release"

pkg_setup() {
	CONFIG_CHECK=()

	if use landlock; then
		CONFIG_CHECK+=("~SECURITY_LANDLOCK")
	fi

	linux-info_pkg_setup
}

src_configure() {
	local emesonargs=(
		"-Dbundle-grpc=false"
		"-Dbundle-landlock=false"
		"-Dbundle-zeroconf=false"
		"-Dinclude-firewall-mod=false"
	)

	meson_src_configure
}

pkg_preinst() {
	gnome2_gconf_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
