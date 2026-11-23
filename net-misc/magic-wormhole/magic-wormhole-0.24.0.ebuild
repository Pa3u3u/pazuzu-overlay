# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..15} )
inherit distutils-r1 optfeature shell-completion

DESCRIPTION="Get things from one computer to another, safely"
HOMEPAGE="https://github.com/magic-wormhole/magic-wormhole"
SRC_URI="
	https://github.com/magic-wormhole/magic-wormhole/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
	+completions
"

PATCHES=(
	"${FILESDIR}/${PN}-no-data-files.patch"
)

RDEPEND="
	${PYTHON_DEPS}
	=dev-python/spake2-0.9*[${PYTHON_USEDEP}]
	dev-python/pynacl[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-17.5.0[ssl,${PYTHON_USEDEP}]
	>=dev-python/autobahn-26[${PYTHON_USEDEP}]
	dev-python/automat[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.13.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
	>=dev-python/txtorcon-18.0.2[${PYTHON_USEDEP}]
	>=dev-python/zipstream-ng-1.7.1[${PYTHON_USEDEP}] <dev-python/zipstream-ng-2
	>=dev-python/iterable-io-1[${PYTHON_USEDEP}] <dev-python/iterable-io-2
	>=dev-python/qrcode-8[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/versioneer
	dev-python/wheel
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/noiseprotocol[${PYTHON_USEDEP}]
		net-misc/magic-wormhole-mailbox-server[${PYTHON_USEDEP}]
		net-misc/magic-wormhole-transit-relay[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

EPYTEST_PLUGINS=( pytest-twisted )
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	if use completions; then
		newbashcomp wormhole_complete.bash wormhole
		newfishcomp wormhole_complete.fish wormhole.fish
		newzshcomp wormhole_complete.zsh _wormhole
	fi
}

pkg_postinst() {
	optfeature "the Dilation API (not used by the wormhole command)" dev-python/noiseprotocol
}
