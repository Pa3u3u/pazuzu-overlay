# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PEVANS
DIST_VERSION=0.50
inherit perl-module

DESCRIPTION="Use HTTP with IO::Async"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-perl/Future-0.280.0
	dev-perl/HTTP-Message
	>=dev-perl/IO-Async-0.590.0
	>=dev-perl/Metrics-Any-0.50.0
	>=dev-perl/Struct-Dumb-0.70.0
	dev-perl/URI
"
BDEPEND="
	${RDEPEND}
	>=dev-perl/Module-Build-0.400.400
	test? (
		dev-perl/HTTP-Cookies
		dev-perl/Test-Metrics-Any
		>=virtual/perl-Test2-Suite-0.0.147
	)
"
