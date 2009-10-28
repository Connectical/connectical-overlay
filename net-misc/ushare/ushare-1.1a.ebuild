# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="UPnP and DLNA media server"
HOMEPAGE="http://ushare.geexbox.org/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.bz2"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=media-libs/libdlna-0.2.3
	>=net-libs/libupnp-1.6"
RDEPEND="${DEPEND}"

src_prepare () {
	epatch "${FILESDIR}/ppc-configure.patch"
}

src_configure () {
	./configure --enable-dlna --prefix=/usr --sysconfdir=/etc
}

src_install () {
	make install DESTDIR="${D}"
	dodoc AUTHORS NEWS README THANKS TODO
	rm -r "${D}/etc/init.d"
}

