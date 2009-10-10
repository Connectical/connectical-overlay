# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="ODF writer for docutils"
HOMEPAGE="http://www.rexx.com/~dkuhlman/#odf-writer-for-docutils"
SRC_URI="http://www.rexx.com/~dkuhlman/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygments-0.9
	>=dev-python/docutils-0.4
	|| (
		>=dev-python/lxml-1.3
		>=dev-python/elementtree-1.2
		>=dev-lang/python-2.5
	)"

