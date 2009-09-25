# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Firmware loader for Ricoh r5u87x-based webcams"
HOMEPAGE="http://www.bitbucket.org/ahixon/r5u87x/"
SRC_URI="http://files.connectical.com/gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libusb-0.1.12
	>=dev-libs/glib-2.16"
RDEPEND="${DEPEND}"


src_compile ()
{
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install ()
{
	dodoc README docs/*.txt

	dosbin "${FILESDIR}/r5u87x-loader"

	exeinto "/usr/$(get_libdir)/${PN}"
	doexe loader

	insinto "/usr/$(get_libdir)/${PN}/ucode"
	doins ucode/*.fw
}
