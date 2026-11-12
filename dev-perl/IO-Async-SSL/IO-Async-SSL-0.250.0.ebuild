# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PEVANS
DIST_VERSION=0.25
inherit perl-module

DESCRIPTION="Use SSL/TLS with IO::Async"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-perl/Future-0.330.0
	>=dev-perl/IO-Async-0.660.0
	>=dev-perl/IO-Socket-SSL-2.3.0
"
BDEPEND="
	${RDEPEND}
	>=dev-perl/Module-Build-0.400.400
	test? (
		>=dev-perl/IO-Async-0.680.0
		dev-perl/Test-Identity
	)
"
