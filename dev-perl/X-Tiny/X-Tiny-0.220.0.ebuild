# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=FELIPE
DIST_VERSION=0.22
inherit perl-module

DESCRIPTION="Super-lightweight exception framework"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Module-Runtime
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-perl/Test-FailWarnings
	)
"
