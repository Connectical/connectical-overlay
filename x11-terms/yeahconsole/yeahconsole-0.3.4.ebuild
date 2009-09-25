# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="Turns xterm into a drop-down console"
HOMEPAGE="http://phrat.de/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""


src_compile () {
	local cc=$(tc-getCC)
	einfo "Compiling yeahconsole.o"
	${cc} ${CFLAGS} -c -o yeahconsole.o yeahconsole.c -I/usr/X11R6/include
	eend $? || die
	einfo "Linking yeahconsole"
	${cc} -o yeahconsole yeahconsole.o -L/usr/X11R6/lib -lX11
	eend $? || die
}


src_install () {
	dobin yeahconsole
	dodoc README
}

