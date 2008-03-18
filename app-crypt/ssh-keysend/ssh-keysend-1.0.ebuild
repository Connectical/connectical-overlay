# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Script to distribute a number of ssh keys in a list of hosts."
HOMEPAGE="http://launchpad.net/ssh-keysend/"
SRC_URI="http://launchpad.net/ssh-keysend/${PV}/${PV}/+download/ssh-keysend-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-shells/bash-3.2
		 >=net-misc/openssh-4.6
		 >=sys-apps/util-linux-2.13"

src_install() {
	doman ${PN}.1
	dodoc README
	dobin ${PN}
}

