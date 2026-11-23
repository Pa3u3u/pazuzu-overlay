# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Open-source implementation of WebSockets and WAMP"
HOMEPAGE="
	https://pypi.org/project/autobahn/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/txaio-25.12.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-50[${PYTHON_USEDEP}]
	>=dev-python/cffi-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/hyperlink-21.0.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/ujson-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/cbor2-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-6.2[${PYTHON_USEDEP}]
	>=dev-python/twisted-22.10.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-20.3.0[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/cffi-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-70.0.0[${PYTHON_USEDEP}]
	test? (
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/argon2-cffi[${PYTHON_USEDEP}]
		dev-python/base58[${PYTHON_USEDEP}]
		dev-python/ecdsa[${PYTHON_USEDEP}]
		dev-python/libpass[${PYTHON_USEDEP}]
		dev-python/pynacl[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/python-snappy[${PYTHON_USEDEP}]
		dev-python/service-identity[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	sed -e '/^\s*"-O3",$/d' \
		-e 's/arch_flag = _get_safe_march_flag(machine)/arch_flag = None/' \
		-i src/autobahn/nvx/_compile_args.py || die
}

python_test() {
	local sitedir=${BUILD_DIR}/install$(python_get_sitedir)

	cd "${T}" || die
	USE_TWISTED=1 "${EPYTHON}" -m twisted.trial --no-recurse \
		autobahn.test \
		autobahn.twisted.test \
		autobahn.websocket.test \
		autobahn.rawsocket.test \
		autobahn.wamp.test \
		autobahn.nvx.test ||
		die "Twisted tests failed with ${EPYTHON}"
	USE_ASYNCIO=1 epytest --ignore="${sitedir}/autobahn/twisted" "${sitedir}/autobahn"
}

pkg_postinst() {
	optfeature "permessage-brotli WebSocket compression" "app-arch/brotli[python]"
	optfeature "permessage-snappy WebSocket compression" dev-python/python-snappy
	optfeature "TLS support" "dev-python/pyopenssl dev-python/service-identity"
	optfeature "WAMP-cryptosign authentication" \
		"dev-python/pynacl dev-python/base58 dev-python/ecdsa"
	optfeature "WAMP-SCRAM authentication" "dev-python/argon2-cffi dev-python/libpass"
}
