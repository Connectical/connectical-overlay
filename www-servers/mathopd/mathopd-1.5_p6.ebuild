# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="mathopd is fast, secure, small webserver, infinitely extensible through cgi scripts."
HOMEPAGE="http://www.mathopd.org/"
MY_P="${P//_p/p}"
SRC_URI="http://www.mathopd.org/dist/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPENDS="sys-lib/glibc"
RDEPENDS="$DEPENDS"
S=${WORKDIR}/${MY_P}/src

src_compile() {
	cd ${S}
	sed -ie 's|# CPPFLAGS = -DHAVE_CRYPT_H|CPPFLAGS = -DHAVE_CRYPT_H|' Makefile
	emake || die
}

src_install() {
	dosbin ${S}/mathopd

	insinto /etc/conf.d
	newins "${FILESDIR}/conf" mathopd

	insinto /etc/mathopd
	newins "${WORKDIR}/${MY_P}/doc/sample.cfg" mathpd.conf.sample

	exeinto /etc/init.d
	newexe "${FILESDIR}/init" mathopd

}


pkg_postinst() {

	enewgroup mathopd
	enewuser mathopd -1 -1 /dev/null mathopd

	einfo "Rename /etc/mathopd/mathopd.conf.sample to mathopd.conf and edit."
	einfo "Refer to http://www.mathopd.org/ for more information."
	ewarn "The config file needs severe polishing and commenting,"
	ewarn "if you're brave enough - please please please do polish it!"
}
