# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Server for DroidMote. Use your androd as remote mouse and keyboard"
HOMEPAGE="http://www.videomap.it/"
SRC_URI="https://www.fi.muni.cz/~xlacko1/deps/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="systemd"

inherit systemd

src_install() {
	dobin "droidmote"

	if use systemd; then
		systemd_douserunit droidmote.service

		elog "Systemd user service is installed in $(systemd_get_userunitdir)."
		elog "Before running the service, setup password as follows:"
		elog
		elog "    systemd --user edit droidmote.service"
		elog
		elog "In the editor, put this in the override section:"
		elog
		elog "    [Service]"
		elog "    Environment=DROIDMOTE_PASSWORD=‹Your password here›"
		elog
		elog "The default port is set to 2302. If you wish, you can override it"
		elog "along with the password, just add another line:"
		elog
		elog "    Environment=DROIDMOTE_PORT=‹Custom port here›"
		elog
		elog "Close the editor and start the service:"
		elog
		elog "    systemctl --user enable --now droidmote"
		elog
		ewarn "The password will be visible in process listing."
		ewarn "There is currently no way around this."
	fi
}
