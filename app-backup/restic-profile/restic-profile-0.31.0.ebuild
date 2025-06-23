# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Dependency Tarball Creation
# ---------------------------
# https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html

# git clone --depth 1 --branch v${PV} 'https://github.com/creativeprojects/resticprofile'
# cd resticprofile
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# XZ_OPT='-T0 -9' tar -acf ${P}.deps.tar.xz go-mod

inherit go-module

DESCRIPTION="Configuration profiles manager for restic backup"
HOMEPAGE="https://creativeprojects.github.io"
SRC_URI="
	https://github.com/creativeprojects/resticprofile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://fi.muni.cz/~xlacko1/deps/${P}.deps.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-backup/restic
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.24.1
"

src_unpack() {
	default

	mv "resticprofile-${PV}" "${P}" || die

	cd "${S}"
	GOFLAGS="${GOFLAGS} -p=$(makeopts_jobs)"
	ego mod verify
	go-env_set_compile_environment
}

src_compile() {
	ego build -v -o resticprofile
}

src_install() {
	dobin resticprofile
}
