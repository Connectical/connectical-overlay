# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool for writing Microsoft compatible boot records"
HOMEPAGE="http://ms-sys.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"


src_compile () {
	make -j1 all PREFIX=/usr
}

src_install () {
	make -j1 install PREFIX=/usr DESTDIR="${D}"
}

