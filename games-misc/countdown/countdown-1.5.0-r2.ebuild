# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Dependency Tarball Creation
# ---------------------------
# https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html

# git clone --depth 1 --branch v${PV} 'https://github.com/Pa3u3u/countdown'
# cd countdown
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# XZ_OPT='-T0 -9' tar -acf ${P}.deps.tar.xz go-mod

DESCRIPTION="Terminal countdown timer"
HOMEPAGE="https://github.com/antonmedv/countdown"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.20"

go_name="github.com/antonmedv/countdown"
base_uri="https://${go_name}"

inherit go-module

SRC_URI="${base_uri}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"

SRC_URI+=" https://www.fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz"

src_unpack() {
	go-module_src_unpack
}

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
}
