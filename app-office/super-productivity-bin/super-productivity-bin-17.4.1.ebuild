# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="An advanced todo list app with timeboxing and time tracking capabilities"
HOMEPAGE="https://super-productivity.com/"
SRC_URI="
	https://raw.githubusercontent.com/super-productivity/super-productivity/refs/heads/master/build/icons/256x256.png -> ${P}.png
	https://github.com/super-productivity/super-productivity/releases/download/v${PV}/latest-linux.yml -> ${P}.yml
	https://github.com/super-productivity/super-productivity/releases/download/v${PV}/superProductivity-x86_64.AppImage -> ${P}.AppImage
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/yq
	dev-libs/openssl
"

MY_PN="super-productivity"

src_unpack() {
	mkdir "$S"
	cp "$DISTDIR/$P.AppImage" "$S/$MY_PN"
	cp "$DISTDIR/$P.yml" "$S/$MY_PN.yml"
	cp "$DISTDIR/$P.png" "$S/$MY_PN.png"
}

src_test() {
	sha512_actual=$(openssl dgst -binary -sha512 "$MY_PN" | openssl base64 -A)
	sha512_expected=$(yq -r '.files[] | select(.url == "superProductivity-x86_64.AppImage") | .sha512' "$MY_PN.yml")
	size_expected=$(yq -r '.files[] | select(.url == "superProductivity-x86_64.AppImage") | .size' "$MY_PN.yml")

	if [ $(stat --format=%s "$MY_PN") -ne "$size_expected" ]; then
		echo "File size does not match the manifest" >&2
		exit 1
	fi

	if [ "$sha512_actual" != "$sha512_expected" ]; then
		echo "SHA512 checksum does not match the manifest" >&2
		exit 1
	fi
}

src_install() {
	dobin "${MY_PN}"
	doicon -s 256 "$MY_PN.png"
	make_desktop_entry --eapi9 "/usr/bin/$MY_PN" -n "Super Productivity" -i "$MY_PN"
}
