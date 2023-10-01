# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake vcs-snapshot

MY_COMMIT="cd0b89df9bac1880ea6ea830251c6b4492d505a5"
DESCRIPTION="Use external locker as X screen saver"
HOMEPAGE="https://github.com/xdbob/xss-lock/"
SRC_URI="https://github.com/xdbob/xss-lock/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+man"

RDEPEND="dev-libs/glib:2
	x11-libs/libxcb
	x11-libs/xcb-util"
DEPEND="${RDEPEND}"
BDEPEND="man? ( dev-python/docutils )"

src_install() {
	cmake_src_install

	dodoc -r "${ED}"/usr/share/doc/${PN}/.
	rm -r "${ED}"/usr/share/doc/${PN} || die
}
