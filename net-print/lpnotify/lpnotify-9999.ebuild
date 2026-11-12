# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module systemd

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.fi.muni.cz/xlacko1/lpnotify.git"
else
	SRC_URI="https://gitlab.fi.muni.cz/xlacko1/lpnotify/-/archive/v${PV}/lpnotify-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Desktop notifications for print jobs on a CUPS server"
HOMEPAGE="https://gitlab.fi.muni.cz/xlacko1/lpnotify"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-lang/perl-5.44
	dev-perl/Future
	dev-perl/GSSAPI
	dev-perl/IO-Async
	|| ( dev-perl/IO-Async-SSL perl-gcpan/IO-Async-SSL )
	dev-perl/IO-Socket-SSL
	dev-perl/Log-Any
	|| ( dev-perl/Log-Any-Adapter-Log4perl perl-gcpan/Log-Any-Adapter-Log4perl )
	dev-perl/Log-Log4perl
	|| ( dev-perl/Net-Async-HTTP perl-gcpan/Net-Async-HTTP )
	dev-perl/Net-SSLeay
	|| ( dev-perl/Promise-ES6 perl-gcpan/Promise-ES6 )
	|| ( >=dev-perl/Protocol-DBus-0.150.0 >=perl-gcpan/Protocol-DBus-0.150.0 )
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-libs/openssl
		dev-perl/HTTP-Message
		dev-perl/URI
		sys-apps/dbus
		virtual/perl-Test2-Suite
	)
"

src_install() {
	perl-module_src_install
	systemd_douserunit systemd/lpnotify.service
}
