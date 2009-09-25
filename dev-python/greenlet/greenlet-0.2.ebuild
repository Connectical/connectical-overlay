# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit distutils

DESCRIPTION="Lightweight in-process concurrent programming"
HOMEPAGE="http://pypi.python.org/pypi/greenlet"
SRC_URI="http://pypi.python.org/packages/source/g/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}"

src_prepare () {
	sed -i -e '/ez_setup/d' setup.py
}

