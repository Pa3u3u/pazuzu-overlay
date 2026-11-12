# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=FELIPE
DIST_VERSION=0.28
inherit perl-module

DESCRIPTION="ES6-style promises in Perl"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-perl/ExtUtils-MakeMaker-CPANfile-0.90.0
	test? (
		dev-perl/Test-Class
		dev-perl/Test-Deep
		dev-perl/Test-FailWarnings
		dev-perl/Test-Fatal
	)
"
