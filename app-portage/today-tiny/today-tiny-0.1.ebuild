# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Automatic update tool for updating Gentoo boxen (tiny version)"
HOMEPAGE="http://code.connectical.com/today"
SRC_URI="http://www.connectical.com/distfiles/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=app-shells/bash-3.0
	>=sys-apps/coreutils-6.9"


src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc README AUTHORS
	dosbin today-tiny
}

