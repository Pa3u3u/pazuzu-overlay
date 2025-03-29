# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Show notifications when PulseAudio volume changes"
HOMEPAGE="https://github.com/Pa3u3u/volume-monitor"
SRC_URI="https://github.com/Pa3u3u/volume-monitor/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
	+systemd
"

DEPEND="
	media-libs/libpulse[dbus]
	media-sound/pulseaudio-daemon[dbus]
	x11-libs/libnotify
"

RDEPEND="
	${DEPEND}
	dev-python/dbus-next
	dev-python/pulsectl
	dev-python/pulsectl-asyncio
"

inherit systemd

src_install() {
	dobin volume-monitor

	if use systemd; then
		systemd_douserunit volume-monitor.service

		elog "Remember to start the service:"
		elog
		elog "    systemctl --user enable --now volume-monitor.service"
		elog
	fi
}
