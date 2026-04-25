# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tiny script that makes easy and secure Android backups"
HOMEPAGE="https://www.openandroidbackup.me/"
SRC_URI="https://github.com/mrrfv/open-android-backup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-alternatives/bc
	app-arch/p7zip
	dev-util/android-tools
	dev-util/dialog
	net-misc/curl
	sys-apps/pv
"
RDEPEND="${DEPEND}"

DESTDIR="/opt/${PN}"

src_install() {
	insinto "${DESTDIR}"

	doins -r companion_app
	doins -r extras
	doins -r functions

	exeinto "${DESTDIR}"
	newexe backup.sh android-backup

	dosym "${DESTDIR}/android-backup" "/usr/bin/open-android-backup"
}
