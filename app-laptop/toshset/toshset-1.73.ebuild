# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Utility to modify HCI/SCI controls on Toshiba Laptops"
HOMEPAGE="http://www.schwieters.org/toshset/"
SRC_URI="http://www.schwieters.org/toshset/toshset.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed -i 's/CFLAGS = -march=i486 \(-Wall @OS_CFLAGS@ @DEBUGFLAGS@\)/CFLAGS := \1 ${CFLAGS}/' "${S}/Makefile.in" || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
