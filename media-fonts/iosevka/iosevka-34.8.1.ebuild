# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Dependency Tarball Creation
# ---------------------------

# $ git switch --detach v${PV}
# $ P=iosevka-$(git describe --tags HEAD | cut -c2-)
# $ rm -rf node_modules
# $ npm install
# $ XZ_OPT='-T0 -9' tar -ac --transform "s,^,${P}/,S" -f ${P}.deps.tar.xz node_modules package*.json

inherit font

DESCRIPTION="Slender typeface for code, from code"
HOMEPAGE="https://typeof.net/Iosevka/"

SRC_URI="
	https://github.com/be5invis/Iosevka/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz
"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="${DEPEND}"
BDEPEND="
	>=net-libs/nodejs-18
	hinting? ( >=media-gfx/ttfautohint-1.8 )
	app-arch/unzip
"

IUSE="
	+ttf
	woff2
	ttc
	+hinting
"

REQUIRED_USE="|| ( ttf woff2 )"

MY_PN="Iosevka"
MY_P="${MY_PN}-${PV}"
MY_FONT="Iosevka"

src_prepare() {
	default

	mv "${WORKDIR}/${MY_P}"/* "${WORKDIR}/${P}/" || die

	for file in 66-iosevka.conf private-build-plans.toml; do
		for suffix in ".${PV}" "."$(ver_cut 1-2) "."$(ver_cut 1) ""; do
			srcfile="${file//./$suffix.}"

			if [ -f "${FILESDIR}/$srcfile" ]; then
				elog "Using file $srcfile -> $file"
				cp "${FILESDIR}/$srcfile" "${WORKDIR}/${P}/${file}" || die
				continue
			fi
		done
	done

	if [ -n "$IOSEVKA_CUSTOM_NAME" ]; then
		elog "Setting build name to $IOSEVKA_CUSTOM_NAME"
		sed -i -e "s/^family = \"Iosevka\"$/family = \"$IOSEVKA_CUSTOM_NAME\"/" \
			"${WORKDIR}/${P}/private-build-plans.toml" || die
	fi
}

src_compile() {
	declare -a targets
	declare -a flags

	mode=""
	if use "!hinting"; then
		mode="-unhinted"
	fi

	for font in ttf woff2; do
		if use "$font"; then
			targets+=("$font$mode::$MY_FONT")
		fi
	done

	if use "ttc"; then
		targets+=("ttc::$MY_FONT")
	fi

	if [ -n "$IOSEVKA_BUILD_JOBS" ]; then
		flags+=("-jCmd=$IOSEVKA_BUILD_JOBS")
	fi

	FONT_CONF=('66-iosevka.conf')
	npm run build -- ${flags[@]} ${targets[@]}
}

src_install() {
	mode=""
	if use "!hinting"; then
		mode="-Unhinted"
	fi

	for font in ttf woff2; do
		use "$font" || continue

		elog "Installing ${font}${mode}"
		FONT_S="${S}/dist/$MY_FONT/${font@U}${mode}" FONT_SUFFIX="$font" \
			font_src_install
	done

	if use ttc; then
		elog "Installing ttc"
		FONT_S="${S}/dist/.ttc/$MY_FONT" FONT_SUFFIX="ttc" \
			font_src_install
	fi
}
