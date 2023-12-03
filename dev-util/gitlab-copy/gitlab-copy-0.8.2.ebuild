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

KEYWORDS="amd64 x86"
SRC_URI="${base_uri}/releases/download/v${PV}/${PN}-v${PV}-linux-amd64.zip -> ${P}.zip"

src_unpack() {
	default_src_unpack

	if [ ! -d "${PN}" ]; then
		die "Expected directory '${PN}' not found"
	fi

	mv "${PN}" "${P}"
}

src_install() {
	dobin ${PN}
}
