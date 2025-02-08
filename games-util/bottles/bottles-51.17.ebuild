# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit gnome2-utils meson python-r1 xdg

DESCRIPTION="Easily run Windows software on Linux with Bottles"
HOMEPAGE="https://usebottles.com/"
SRC_URI="https://github.com/bottlesdevs/Bottles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
	gamemode
	+gvfs
	vkd3d
	vkd3d-proton
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	app-arch/cabextract
	app-arch/p7zip
	app-arch/patool
	dev-lang/python
	dev-libs/libportal[gtk]
	dev-python/chardet
	dev-python/fvs
	dev-python/markdown
	dev-python/orjson
	dev-python/pathvalidate
	dev-python/pycurl
	dev-python/pygobject
	dev-python/pyyaml
	dev-python/requests
	dev-python/vkbasalt-cli
	gnome-base/dconf
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita
	media-gfx/imagemagick
	media-gfx/vkBasalt
	x11-apps/xdpyinfo
	x11-themes/hicolor-icon-theme
"

RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	gamemode? ( games-util/gamemode )
	gvfs? ( gnome-base/gvfs )
	vkd3d? ( app-emulation/vkd3d )
	vkd3d-proton? ( app-emulation/vkd3d-proton )
"
BDEPEND="
	dev-build/meson
	dev-build/ninja
	dev-util/blueprint-compiler
"

PATCHES=(
	"${FILESDIR}/allow-non-flatpak.patch"
	"${FILESDIR}/disable-flatpak-check.patch"
)

EMESON_BUILDTYPE="release"

src_unpack() {
	default

	mv "Bottles-${PV}" "${P}" || die
}

src_configure() {
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

#epends=(
#  python-fvs
#  python-steamgriddb
#  vkbasalt-cli
#)
