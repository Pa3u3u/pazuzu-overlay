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

src_install() {
	dobin "droidmote"

	if use systemd; then
		docompress -x /usr/share/doc/"${PF}"
		dodoc "droidmote.service"
		dodoc "droidmote.env"

		elog "SystemD unit and environment is stored in"
		elog ""
		elog "    /usr/share/doc/${PF}"
		elog ""
		elog "To use droidmote as the running user, please do the following:"
		elog ""
		elog "    mkdir -p \$HOME/.config/systemd/user"
		elog "    cp /usr/share/doc/${P}*/droidmote.{service,env} \$HOME/.config/systemd/user/"
		elog ""
		elog "Edit the droidmote.env file, uncomment 'DROIDMOTE_PASSWORD' variable and change it:"
		elog ""
		elog "    \${EDITOR:-nano} \$HOME/.config/systemd/user/droidmote.env"
		elog ""
		elog "Finally, to enable (and start) the unit, run"
		elog ""
		elog "    systemctl --user enable [--now] droidmote.service"
		elog ""
		elog "To run unit without enabling, run"
		elog ""
		elog "    systemctl --user start droidmote.service"
	fi
}
