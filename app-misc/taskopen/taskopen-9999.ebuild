# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tool for taking notes and open urls with taskwarrior"
HOMEPAGE="https://github.com/jschlatow/taskopen/wiki"

LICENSE="GPL-2"
SLOT="0"

if [ "$PV" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/jschlatow/taskopen"
	inherit git-r3
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/jschlatow/$PN/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"
fi

DEPEND="
	=app-misc/task-2*
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/nim-1.4.0
"
