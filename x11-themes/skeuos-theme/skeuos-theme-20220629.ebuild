# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Skeuos theme"
HOMEPAGE="https://www.gnome-look.org/p/1441725/"
SRC_URI="https://github.com/daniruiz/skeuos-gtk/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/sassc
	media-gfx/inkscape
	media-gfx/optipng
"

THEME_STYLES=(
	light
	dark
)

THEME_COLORS=(
	black
	blue
	brown
	cyan
	green
	grey
	magenta
	orange
	red
	teal
	violet
	white
	yellow
)

THEME_DE=(
	cinnamon
	gnome-shell
	gtk2
	gtk3
	metacity
	xfwm4
)

IUSE="
	${THEME_STYLES[*]/#/+}
	${THEME_COLORS[*]/#/+}
	${THEME_DE[*]/#gtk/+gtk}
"

REQUIRED_USE="|| ( ${THEME_STYLES[*]} ) || ( ${THEME_COLORS[*]} )"

src_unpack() {
	default
	mv "skeuos-gtk-${PV}" "${P}" || die
}

src_compile() {
	#emake build
	echo "Nothing to be installed"
}

src_install() {
	insinto /usr/share/themes

	for color in ${THEME_COLORS[*]}; do
		for style in ${THEME_STYLES[*]}; do
			if [ "${color}-{$style}" = "white-light" ] || [ "${color}-${style}" = "black-dark" ]; then
				continue
			fi

			if use ${color} && use ${style}; then
				doins -r themes/"Skeuos-${color^}-${style^}"

				if use xfwm4; then
					doins -r themes/"Skeuos-${color^}-${style^}"-XFWM*
				fi

				if use gnome-shell; then
					doins -r themes/"Skeuos-${color^}-${style^}"{,-FullPanel}-GNOME*
				fi
			fi
		done
	done
}
