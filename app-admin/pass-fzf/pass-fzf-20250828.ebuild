# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An extension for pass that allows fuzzy finding in the store"
HOMEPAGE="https://github.com/ficoos/pass-fzf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-admin/pass
	app-shells/fzf
"

RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://github.com/Pa3u3u/pass-fzf"
EGIT_COMMIT="57931359dcc5f21d4fe367c14b117a32e8d6abde"

inherit git-r3

src_install() {
	exeinto "/usr/lib/password-store/extensions"
	doexe fzf.bash
}
