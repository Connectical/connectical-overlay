# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="mailx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Advanced implementation of the mailx command"
HOMEPAGE="http://heirloom.sourceforge.net/mailx.html"
SRC_URI="mirror://sourceforge/heirloom/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9
	virtual/libiconv
	virtual/mta
	!virtual/mailutils
	!virtual/mailx"
RDEPEND="${DEPEND}"

PROVIDE="virtual/mailx"


src_compile ()
{
	emake PREFIX=/usr SYSCONFDIR=/etc MAILSPOOL=/var/spool/mail STRIP=: \
	      CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
	      MANDIR=/usr/share/man BINDIR=/bin DESTDIR="${D}" \
	      UCBINSTALL=/usr/bin/install SENDMAIL=/usr/sbin/sendmail
}


src_install ()
{
	emake PREFIX=/usr SYSCONFDIR=/etc MAILSPOOL=/var/spool/mail STRIP=: \
	      CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
	      MANDIR=/usr/share/man BINDIR=/bin DESTDIR="${D}" \
	      UCBINSTALL=/usr/bin/install SENDMAIL=/usr/sbin/sendmail install

	dosym mailx /bin/Mail
	dosym mailx /bin/mail

	dosym mailx.1 /usr/share/man/man1/Mail.1
	dosym mailx.1 /usr/share/man/man1/mail.1

	dohtml mailx.1.html
	dodoc README TODO
}

