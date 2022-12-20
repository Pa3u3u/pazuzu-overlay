# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An undelete tool for XFS filesystem"
HOMEPAGE="https://github.com/ianka/xfs_undelete"

LICENSE="GPL-3"
SLOT="0"

IUSE="
	doc
	+file
"

DEPEND="
	>=dev-lang/tcl-8.6
	dev-tcltk/tcllib
	file? ( sys-apps/file )
"

RDEPEND="${DEPEND}"
BDEPEND=""

GIT_REPO_URI="https://github.com/ianka/xfs_undelete"

if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="${GIT_REPO_URI}"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="${GIT_REPO_URI}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

src_unpack() {
	default
	mv "${WORKDIR}/xfs_undelete-${PV}" "${WORKDIR}/${P}"
	mv "${WORKDIR}/${P}/xfs_undelete.man" "${WORKDIR}/${P}/xfs_undelete.1"
}

src_install() {
	dobin xfs_undelete

	if use doc; then
		doman xfs_undelete.1
	fi
}
