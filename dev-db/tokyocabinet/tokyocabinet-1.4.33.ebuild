# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A high performance database library similar to the DBM family"
HOMEPAGE="http://1978th.net/tokyocabinet/"
SRC_URI="http://1978th.net/tokyocabinet/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bzip2 +zlib +threadas fastest -debug -static -devel -off64 -profile
	 -uyield +shared -swab doc"

DEPEND="bzip2? ( >=app-arch/bzip2-1.0.5 )
		zlib?  ( >=sys-libs/zlib-1.2.3 )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	# Optional features
	use bzip2   || myconf="${myconf} --disable-bzip"
	use zlib    || myconf="${myconf} --disable-zlib"
	use threads || myconf="${myconf} --disable-pthread"
	use shared  || myconf="${myconf} --disable-shared"

	econf $(use_enable debug) $(use_enable static) \
		  $(use_enable fastest) $(use_enable devel) \
		  $(use_enable profile) $(use_enable off64) \
		  $(use_enable swab) $(use_enable uyield) ${myconf} ||
		  die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc Changelog THANKS README
	if use doc ; then
		dohtml doc/*
	fi
}

