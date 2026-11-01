# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Dependency Tarball Creation
# ---------------------------
# https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html

# git clone --depth 1 --branch v${PV} 'https://github.com/ajeetdsouza/clidle.git'
# cd clidle
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# XZ_OPT='-T0 -9' tar -acf ${P}.deps.tar.xz go-mod

inherit go-module

DESCRIPTION="Wordle in terminal"
HOMEPAGE="https://github.com/ajeetdsouza/clidle"
SRC_URI="
	https://github.com/ajeetdsouza/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.22.0
"

src_unpack() {
	default

	cd "${S}"
	GOFLAGS="${GOFLAGS} -p=$(makeopts_jobs)"
	ego mod verify
	go-env_set_compile_environment
}

src_compile() {
	ego build -v -o "${PN}"
}

src_install() {
	dobin "${PN}"
}
