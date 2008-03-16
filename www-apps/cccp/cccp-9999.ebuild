# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EBZR_SRC_URI="bzr+http://code.connectical.com/${PN}/bzr/trunk"

inherit distutils bazaar

DESCRIPTION="Connectical Community Content Portal"
HOMEPAGE="https://code.connectical.com/cccp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	>=dev-python/paste-1.2"

