# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EBZR_SRC_URI="http://bazaar.launchpad.net/~acastro-connectical/cccp/main"

inherit distutils bazaar

DESCRIPTION="Connectical Community Content Portal"
HOMEPAGE="https://launchpad.net/cccp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	>=dev-python/paste-1.2"

