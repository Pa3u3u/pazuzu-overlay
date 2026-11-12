# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..14} )

inherit python-single-r1 systemd

DESCRIPTION="systemd password agent presenting GUI prompts via zenity"
HOMEPAGE="https://gitlab.fi.muni.cz/xlacko1/zenity-ask-pass"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	acct-group/ask-pass
	gnome-extra/zenity
	sys-apps/systemd
	sys-auth/polkit
"

src_prepare() {
	default
	sed -i "s|%h/\.local/bin/|${EPREFIX}/usr/bin/|" systemd/${PN}.service || die
}

src_install() {
	python_doscript ${PN}

	systemd_douserunit systemd/${PN}.service systemd/${PN}.path

	insinto /usr/share/polkit-1/rules.d
	doins polkit/49-${PN}.rules
}

pkg_postinst() {
	elog "To answer password requests from system services, add your user"
	elog "to the ask-pass group and log in again:"
	elog "    gpasswd -a <user> ask-pass"
	elog
	elog "Enable the agent for your user, either running for the whole session:"
	elog "    systemctl --user enable --now ${PN}.service"
	elog "or started on demand when a request arrives:"
	elog "    systemctl --user enable --now ${PN}.path"
	elog
	elog "The agent needs DISPLAY or WAYLAND_DISPLAY in the systemd user"
	elog "environment; most desktops import it there automatically."
}
