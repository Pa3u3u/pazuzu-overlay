# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Dependency Tarball Creation
# ---------------------------
# https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html

# git clone --depth 1 --branch v6.2.3 https://github.com/keybase/client.git
# cd client/go
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# XZ_OPT='-T0 -9' tar -acf keybase-6.2.3.deps.tar.xz go-mod

DESCRIPTION="Client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="
	https://github.com/keybase/client/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://www.fi.muni.cz/~xlacko1/deps/keybase-${PV}.deps.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
	browser
	gui
	+kbfs
	systemd
"

DEPEND=""
RDEPEND="
	${DEPEND}
	app-crypt/gnupg
	systemd? (
		sys-apps/systemd
	)
"

BDEPEND="
	verify-sig? (
		app-crypt/gnupg
		sec-keys/openpgp-keys-keybaseio
	)
	gui? (
		net-print/cups
		sys-apps/yarn
	)
	kbfs? (
		sys-fs/fuse
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/openpgp-keys/keybase.io.asc"

RESTRICT="gui? ( network-sandbox )"

CLIENT_DIR="client-${PV}"

inherit verify-sig systemd go-module desktop xdg-utils

src_unpack() {
	if use verify-sig; then
		verify-sig_verify_detached "${DISTDIR}"/${P}.tar.xz{,.sig}
	fi

	default
	ln -vs "${CLIENT_DIR}" "${P}" || die
	mkdir -p "${T}/src/github.com/keybase"
	ln -vs "${WORKDIR}/${CLIENT_DIR}" "${T}/src/github.com/keybase/client"
}

src_prepare() {
	default_src_prepare

	if use gui; then
		echo "PREPARING"
		# Use nicer icon for keybase over the default.
		resource="resources/app/images/icons/icon-keybase-logo-128.png"
		file="${WORKDIR}/${P}/packaging/linux/keybase.desktop"
		sed -i "s,^Icon=.*,Icon=/opt/${PN}/${resource},g" "${file}"
	fi
}

src_compile() {
	export GOPATH=${T}

	cd "${WORKDIR}/${CLIENT_DIR}/go"

	elog "Building keybase"
	ego build -a -tags production  -o "${T}/keybase" \
		github.com/keybase/client/go/keybase

	if use browser; then
		elog "Building kbnm"
		ego build -a -tags production -o "${T}/kbnm" \
			github.com/keybase/client/go/kbnm
	fi

	if use kbfs; then
		elog "Building kbfs"
		ego build -a -tags production -o "${T}/kbfsfuse" \
			github.com/keybase/client/go/kbfs/kbfsfuse
		ego build -a -tags production -o "${T}/git-remote-keybase" \
			github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase
		ego build -a -tags production -o "${T}/keybase-redirector" \
			github.com/keybase/client/go/kbfs/redirector
	fi

	if use gui; then
		use x86   && arch=ia32
		use amd64 && arch=x64

		cd ../shared
		yarn
		yarn run package -- --platform linux --arch "${arch}" --appVersion "${PV}"
	fi
}

src_install() {
	dobin "${T}/keybase"
	dobin "${S}/packaging/linux/run_keybase"

	if use systemd; then
		systemd_douserunit "${S}/packaging/linux/systemd/keybase.service"
	fi

	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"

	doins "${S}/packaging/linux/crypto_squirrel.txt"

	if use gui; then
		use x86   && arch="ia32"
		use amd64 && arch="x64"

		pushd "${S}/shared/desktop/release/linux-${arch}/Keybase-linux-${arch}"
		doins -r *
		doexe chrome-sandbox Keybase
		popd

		if use systemd; then
			systemd_douserunit "${S}/packaging/linux/systemd/keybase.gui.service"
		fi

		domenu "${WORKDIR}/${P}/packaging/linux/keybase.desktop"
	fi

	if use browser; then
		dobin "${T}/kbnm"
		KBNM_INSTALL_ROOT=1 KBNM_INSTALL_OVERLAY="${D}" "${D}/usr/bin/kbnm" install
	fi

	if use kbfs; then
		dobin "${T}/kbfsfuse" "${T}/git-remote-keybase" "${T}/keybase-redirector"

		if use systemd; then
			systemd_douserunit "${S}/packaging/linux/systemd/kbfs.service"
			systemd_douserunit "${S}/packaging/linux/systemd/keybase-redirector.service"
		fi
	fi
}

pkg_postinst() {
	xdg_desktop_database_update

	elog "Start/Restart keybase: run_keybase"
	elog "Run the service:       keybase service"
	elog "Run the client:        keybase login"
}

pkg_postrm() {
	xdg_desktop_database_update
}
