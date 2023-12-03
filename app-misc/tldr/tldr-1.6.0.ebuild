# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Community-maintained help pages for command-line tools"
HOMEPAGE="https://github.com/tldr-pages/tldr-c-client"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gcc
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-Makefile-DESTDIR.patch"
)

base_uri="https://github.com/tldr-pages/tldr-c-client"

KEYWORDS="amd64 x86"
SRC_URI="${base_uri}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

src_unpack() {
	default_src_unpack

	name_prefix="tldr-c-client"
	if [ ! -d "${name_prefix}-${PV}" ]; then
		die "Expected directory '${name_prefix}-${PV}' not found"
	fi

	mv "${name_prefix}-${PV}" "${P}"
}
