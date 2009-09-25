# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EBZR_SRC_URI="lp:pydoctor"

inherit distutils bazaar

DESCRIPTION="API documentation tool for Python by the Twisted crew"
HOMEPAGE="http://codespeak.net/~mwh/pydoctor/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND=">=dev-python/nevow-0.9.18"
RDEPEND="${DEPEND}"

