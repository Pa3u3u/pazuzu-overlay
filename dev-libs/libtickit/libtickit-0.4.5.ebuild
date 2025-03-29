# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminal Interface Construction Kit"
HOMEPAGE="https://github.com/leonerd/libtickit"

LICENSE="MIT"
SLOT="0"

IUSE="
	unibilium"

DEPEND="
	dev-libs/libtermkey
	unibilium? ( >=dev-libs/unibilium-1.1 )
	!unibilium? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-disable-man-compression.patch"
)

base_uri="https://github.com/leonerd/libtickit"

case "${PV}" in
	9999)
		inherit git-r3

		EGIT_REPO_URI="${base_uri}"
		;;
	*)
		KEYWORDS="~amd64 ~x86"
		SRC_URI="${base_uri}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
		;;
esac

src_install() {
	emake PREFIX="${D}/usr" LIBDIR="${D}/usr/lib64" install

	sed -ie "s!${D}!!" "${D}/usr/$(get_libdir)/pkgconfig/tickit.pc"
	unlink "${D}/usr/$(get_libdir)/pkgconfig/tickit.pce"
	ln -s tickit.pc "${D}/usr/$(get_libdir)/pkgconfig/libtickit.pc"

	einstalldocs
}
