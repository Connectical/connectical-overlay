# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="Referencer is a Gnome application to organise documents or
references, and ultimately generate a BibTeX bibliography file."
HOMEPAGE="http://icculus.org/~jcspray/referencer/"
SRC_URI="http://icculus.org/~jcspray/referencer/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND=">=app-text/poppler-0.5.0
	>=dev-cpp/gtkmm-2.8
	>=dev-cpp/libgnomeuimm-2.14.0
	>=dev-cpp/gnome-vfsmm-2.14.0
	>=dev-cpp/libglademm-2.6.0
	>=dev-cpp/gconfmm-2.14.0
	dev-libs/boost
	python? ( dev-lang/python )"
RDEPEND=""

src_compile() {
	econf --disable-update-mime-database $(use_enable python) \
		|| die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed!"
}

pkg_postinst() {
	update-mime-database "/usr/share/mime"
}

pkg_postrm() {
	update-mime-database "/usr/share/mime"
}

