# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool for copying issues, labels etc. between GitLab projects"
HOMEPAGE="https://github.com/gotsunami/gitlab-copy"

LICENSE="MIT"
SLOT="0"

DEPEND="
	net-misc/curl
	dev-libs/libzip"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip"

go_name="github.com/gotsunami/gitlab-copy"
base_uri="https://${go_name}"

case "${PV}" in
	9999)
		inherit git-r3

		BDEPEND="${BDEPEND}
			>=dev-lang/go-1.5"

		PATCHES=(
			"${FILESDIR}/${P}-remove-pagination-limit.patch"
		)

		EGIT_REPO_URI="${base_uri}"
		;;
	*)
		KEYWORDS="~amd64 ~x86"
		SRC_URI="${base_uri}/releases/download/v${PV}/gitlab-copy-v${PV}-linux-amd64.zip -> ${P}.zip"
		;;
esac

src_unpack() {
	default_src_unpack

	if [ "${PV}" = "9999" ]; then
		git-r3_src_unpack

		pushd "${S}"
		rm "Gopkg.lock" "Gopkg.toml"
		cp "${FILESDIR}/go.mod" "go.mod"

		go mod tidy
		go mod vendor
		popd
	else
		name_prefix="gitlab-copy"
		if [ ! -d "${name_prefix}" ]; then
			die "Expected directory '${name_prefix}' not found"
		fi

		mv "${name_prefix}" "${P}"
	fi
}

src_configure() {
	default_src_configure

	if [ "${PV}" = "9999" ]; then
		tools/version.sh
	fi
}

src_compile() {
	if [ "${PV}" = "9999" ]; then
		go build -o ${PN} "${go_name}/cmd/gitlab-copy"
	else
		default_src_compile
	fi
}

src_install() {
	dobin ${PN}
}
