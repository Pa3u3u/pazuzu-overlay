# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=FELIPE
DIST_VERSION=0.16
inherit perl-module

DESCRIPTION="Convenience wrapper for frame-based I/O"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-perl/IO-SigGuard-0.13.0
	dev-perl/X-Tiny
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-perl/Test-Exception
		dev-perl/Test-FailWarnings
	)
"
