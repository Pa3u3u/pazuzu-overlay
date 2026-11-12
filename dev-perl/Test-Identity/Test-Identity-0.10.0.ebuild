# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PEVANS
DIST_VERSION=0.01
inherit perl-module

DESCRIPTION="Assert the referential identity of a reference"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-perl/Module-Build-0.360.0
"
