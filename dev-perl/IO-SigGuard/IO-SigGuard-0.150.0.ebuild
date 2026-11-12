# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=FELIPE
DIST_VERSION=0.15
inherit perl-module

DESCRIPTION="SA_RESTART in pure Perl"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-perl/File-Slurp
		dev-perl/Test-Deep
	)
"
