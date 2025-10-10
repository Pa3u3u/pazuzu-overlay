# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Original source:
# https://data.gpo.zugaina.org/r7l/app-text/obsidian/obsidian-1.4.14.ebuild

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A second brain, for you, forever"
HOMEPAGE="https://obsidian.md"
SRC_URI="https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${PN}_${PV}_amd64.deb"

S="${WORKDIR}"

# The complete license overview is here: https://obsidian.md/license
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

src_prepare() {
	default

	# Fix desktop file
	sed -i 's|/opt/Obsidian/obsidian|/opt/obsidian/obsidian|g' "${S}/usr/share/applications/obsidian.desktop"
}

src_install() {
	insinto /opt/obsidian
	doins -r opt/Obsidian/*

	# Desktop file
	domenu usr/share/applications/obsidian.desktop

	# Icons
	for size in 16 32 48 64 128 256 512; do
		doicon --size "${size}" "usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png"
	done

	# Fix permissions
	fperms 4755 /opt/obsidian/chrome-sandbox || die
	fperms +x  /opt/obsidian/obsidian || die

	# Link the executable
	dosym ../../opt/obsidian/obsidian /usr/bin/obsidian
}
