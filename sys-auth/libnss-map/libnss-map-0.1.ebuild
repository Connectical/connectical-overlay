# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libnss-cache/libnss-cache-0.1.ebuild,v 1.3 2009/10/23 16:07:48 vostorga Exp $

inherit eutils multilib

DESCRIPTION="libnss-map is a nss library to map users to virtual one."
HOMEPAGE="http://connectical.com/projects/libnss-map"
SRC_URI="http://files.connectical.com/gentoo/${PN//-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN//-/_}"

src_install() {
	dolib src/libnss_map.so

	insinto /etc
	doins samples/libnss_map.conf
	dodoc README
}
