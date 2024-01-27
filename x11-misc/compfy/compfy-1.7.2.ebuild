# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="A compositor forked from Picom with animations and more features"
HOMEPAGE="https://github.com/allusive-dev/compfy"
SRC_URI="https://github.com/allusive-dev/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="
	+config-file
	dbus
	+doc
	+drm
	+opengl
	+pcre
"

DEPEND="
	dev-libs/libev
	dev-libs/libxdg-basedir
	dev-libs/uthash
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/pixman
	x11-libs/xcb-util-image
	x11-libs/xcb-util-renderutil

	config-file? (
		dev-libs/libconfig
	)
	dbus? (
		sys-apps/dbus
	)
	drm? (
		x11-libs/libdrm
	)
	pcre? (
		dev-libs/libpcre2
	)
	opengl? (
		virtual/opengl
	)
"

RDEPEND="
	${DEPEND}
	x11-base/xorg-proto
"

BDEPEND="
	app-alternatives/ninja
"

DOCS=( README.md compfy.sample.conf )

EMESON_BUILDTYPE="release"

src_configure() {
	local emesonargs=(
		$(meson_use config-file config_file)
		$(meson_use dbus)
		$(meson_use doc with_docs)
		$(meson_use drm vsync_drm)
		$(meson_use opengl)
		$(meson_use pcre regex)
	)

	meson_src_configure
}
