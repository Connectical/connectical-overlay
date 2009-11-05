# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="SPU libraries bundled with SDL"
HOMEPAGE="http://libsdl.org"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~ppc64"
IUSE=""

RDEPEND="sys-libs/libspe2"
DEPEND="${RDEPEND}
	cross-spu-elf/gcc"

S="${WORKDIR}/SDL-${PV}/src/video/ps3/spulibs"


src_install () {
	mkdir -p "${D}/usr/lib"
	make install PREFIX="${D}/usr/lib"
}

