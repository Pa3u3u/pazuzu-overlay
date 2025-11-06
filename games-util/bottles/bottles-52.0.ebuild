# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

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
	>=app-arch/patool-3.0.0
	dev-lang/python
	dev-libs/libportal[gtk]
	>=dev-python/certifi-2024.8.30
	>=dev-python/chardet-5.2.0
	>=dev-python/charset-normalizer-3.3.2
	>=dev-python/fvs-0.3.4
	>=dev-python/icoextract-0.1.5
	>=dev-python/idna-3.10
	>=dev-python/markdown-3.7
	>=dev-python/orjson-3.10.7
	>=dev-python/pathvalidate-3.2.1
	>=dev-python/pefile-2024.8.26
	>=dev-python/pycairo-1.27.0
	>=dev-python/pycurl-7.45.3
	>=dev-python/pygobject-3.50.0
	>=dev-python/pyyaml-6.0.2
	>=dev-python/requests-2.32.3
	>=dev-python/urllib3-2.2.3
	dev-python/vkbasalt-cli
	>=dev-python/wheel-0.44.0
	gnome-base/dconf
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	>=gui-libs/libadwaita-1.7
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
	"${FILESDIR}/allow-non-flatpak-52.0.patch"
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
