# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EBZR_SRC_URI="bzr+http://code.connectical.com/today/bzr/tiny"

inherit bazaar

DESCRIPTION="Automatic update tool for updating Gentoo boxen (tiny version)"
HOMEPAGE="http://code.connectical.com/today"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ppc"
IUSE=""

RDEPEND=">=app-shells/bash-3.0
	>=sys-apps/coreutils-6.9"


src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc README AUTHORS
	dosbin today-tiny
	insinto /etc
	doins etc/today-tiny.conf.example
}

