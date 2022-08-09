# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign Keybase.io releases"
HOMEPAGE="https://github.com/keybase/client/releases"

SRC_URI="
	https://keybase.io/docs/server_security/code_signing_key.asc
		-> keybase.io.asc
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_unpack() {
	default
	mkdir -p "${S}"
}

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - keybase.io.asc < <(cat "${files[@]/#/${DISTDIR}/}")
}
