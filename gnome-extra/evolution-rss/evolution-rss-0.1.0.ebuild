# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit gnome2

DESCRIPTION="An RSS reader plugin for Evolution"
HOMEPAGE="http://gnome.eu.org/index.php/Evolution_RSS_Reader_Plugin"
SRC_URI="http://gnome.eu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus webkit xulrunner"

RDEPEND=">=mail-client/evolution-2.22
	>=gnome-base/gconf-2
	net-libs/libsoup:2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2
	>=gnome-extra/evolution-data-server-1.2
	dbus? ( dev-libs/dbus-glib )
	webkit? ( net-libs/webkit-gtk )
	xulrunner? ( >=net-libs/xulrunner-1.9 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21
	sys-devel/libtool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog FAQ NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable xulrunner gecko)"
	G2CONF="${G2CONF} $(use_enable dbus)"
	G2CONF="${G2CONF} $(use_enable webkit)"
	G2CONF="${G2CONF} --with-gecko=libxul"
}
