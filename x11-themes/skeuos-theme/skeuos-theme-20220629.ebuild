# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Skeuos theme"
HOMEPAGE="https://www.gnome-look.org/p/1441725/"
SRC_URI="https://github.com/daniruiz/skeuos-gtk/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

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

src_configure() {
	mv "themes" "themes-all"
	mkdir "themes"

	for color in ${THEME_COLORS[*]}; do
		for style in ${THEME_STYLES[*]}; do
			if [ "${color}-${style}" = "white-light" ] || [ "${color}-${style}" = "black-dark" ]; then
				continue
			fi

			if use ${color} && use ${style}; then
				mv themes{-all,}/"Skeuos-${color^}-${style^}"

				if use xfwm4; then
					mv themes{-all,}/"Skeuos-${color^}-${style^}"-XFWM*
				fi

				if use gnome-shell; then
					mv themes{-all,}/"Skeuos-${color^}-${style^}"{,-FullPanel}-GNOME*
				fi
			fi
		done
	done
}

src_compile() {
	COLOR_VARIANTS=()
	for color in ${THEME_COLORS[*]}; do
		if use "$color"; then
			COLOR_VARIANTS+=("${color^}")
		fi
	done

	echo "${COLOR_VARIANTS[*]}"
	emake build COLOR_VARIANTS="${COLOR_VARIANTS[*]}"
}

src_install() {
	insinto /usr/share/themes

	for theme in themes/*; do
		doins -r "$theme"
	done
}
