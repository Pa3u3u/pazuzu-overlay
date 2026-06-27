EAPI=8

USE_RUBY="ruby33 ruby34 ruby40"

inherit ruby-fakegem

DESCRIPTION="Manage complex tmux sessions easily"
HOMEPAGE="https://github.com/tmuxinator/tmuxinator"
SRC_URI="https://github.com/tmuxinator/tmuxinator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	>=dev-ruby/erubi-1.13
	>=dev-ruby/thor-1.4.0
"
