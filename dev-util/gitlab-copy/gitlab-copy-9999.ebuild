# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool for copying issues, labels etc. between GitLab projects"
HOMEPAGE="https://github.com/gotsunami/gitlab-copy"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip"

go_name="github.com/gotsunami/gitlab-copy"
base_uri="https://${go_name}"

case "${PV}" in
	9999)
		inherit git-r3 go-module

		BDEPEND="${BDEPEND}
			=dev-lang/go-1.20"

		PATCHES=(
			"${FILESDIR}/${P}-remove-pagination-limit.patch"
			"${FILESDIR}/${P}-fix-embedded-struct.patch"
		)

		EGIT_REPO_URI="${base_uri}"
		SRC_URI="https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz"
		;;
	*)
		KEYWORDS="~amd64 ~x86"
		SRC_URI="${base_uri}/releases/download/v${PV}/${PN}-v${PV}-linux-amd64.zip -> ${P}.zip"
		;;
esac

src_unpack() {
	if [ "${PV}" = 9999 ]; then
		git-r3_src_unpack
		go-module_src_unpack
	else
		default_src_unpack

		if [ ! -d "${PN}" ]; then
			die "Expected directory '${PN}' not found"
		fi

		mv "${PN}" "${P}"
	fi
}

src_install() {
	if [ "${PV}" = 9999 ]; then
		dobin bin/"${PN}"
	else
		dobin ${PN}
	fi
}
