# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Open implementation of the DLNA standard"
HOMEPAGE="http://libdlna.geexbox.org/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.bz2"

LICENSE="LGPL2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.5"
RDEPEND="${DEPEND}"

src_prepare () {
	# XXX Hack, hack, hack!
	mkdir ffmpeg
	ln -s /usr/include/libav*/*.h ffmpeg/
	epatch "${FILESDIR}/ppc-configure.patch"
}

src_configure () {
	./configure --prefix=/usr --with-ffmpeg-dir=$(pwd)
}

src_install () {
	make install DESTDIR="${D}"
	dodoc README AUTHORS
}

