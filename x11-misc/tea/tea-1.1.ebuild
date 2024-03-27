# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux command-line utility to display short timer notifications"
HOMEPAGE="https://github.com/Pa3u3u/tea"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	>=dev-lang/perl-5.38
	>=dev-perl/AnyEvent-7.170
	>=dev-perl/IPC-System-Simple-1.300
	>=dev-perl/Net-DBus-1.2
	>=dev-perl/Time-Duration-1.210
	>=dev-perl/XML-Twig-3.520
	|| ( >=dev-perl/AnyEvent-DBus-0.30 >=perl-gcpan/AnyEvent-DBus-0.30 )
"

RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="
	doc
"

SRC_URI="https://github.com/Pa3u3u/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

src_compile() {
	default

	use doc \
		&& pod2man --utf8 "${WORKDIR}/${P}/tea" >"${WORKDIR}/${P}/tea.1"
}

src_install() {
	dobin tea

	use doc \
		&& doman tea.1
}
