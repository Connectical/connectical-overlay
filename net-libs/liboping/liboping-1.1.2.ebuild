# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils perl-module

DESCRIPTION="liboping is a C library to generate ICMP echo requests, better
known as “ping packets"
HOMEPAGE="http://verplant.org/liboping/"
SRC_URI="http://verplant.org/liboping/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl )"
RDEPEND="${DEPEND}"


src_compile () {
	econf $(use_with perl perl-bindings) && emake
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README NEWS

	# Fix perllocal.pod file collision
	use perl && fixlocalpod
}

