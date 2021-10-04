# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Community-maintained help pages for command-line tools."
HOMEPAGE="https://github.com/tldr-pages/tldr-c-client"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gcc
	app-arch/zip
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-Makefile-DESTDIR.patch"
)

base_uri="https://github.com/tldr-pages/tldr-c-client"

case "${PV}" in
	9999)
		inherit git-r3
		EGIT_REPO_URI="${base_uri}"
		;;
	*)
		KEYWORDS="~amd64 ~x86"
		SRC_URI="${base_uri}/archive/refs/tags/v${PV}.zip -> ${P}.zip"
		;;
esac

src_unpack() {
	default_src_unpack

	name_prefix="tldr-c-client"
	if [ ! -d "${name_prefix}-${PV}" ]; then
		die "Expected directory '${name_prefix}-${PV}' not found"
	fi

	mv "${name_prefix}-${PV}" "${P}"
}
