# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=FELIPE
DIST_VERSION=0.22
inherit perl-module

DESCRIPTION="D-Bus in pure Perl"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Call-Context
	>=dev-perl/IO-Framed-0.160.0
	dev-perl/IO-SigGuard
	dev-perl/Module-Runtime
	dev-perl/Promise-ES6
	dev-perl/X-Tiny
"
BDEPEND="
	${RDEPEND}
	>=dev-perl/ExtUtils-MakeMaker-CPANfile-0.90.0
	test? (
		dev-perl/File-Which
		dev-perl/Test-Deep
		dev-perl/Test-Exception
		dev-perl/Test-FailWarnings
		dev-perl/Test-SharedFork
	)
"
