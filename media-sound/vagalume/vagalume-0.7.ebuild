# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="GTK+-based Last.fm client"
HOMEPAGE="http://vagalume.igalia.com/"
SRC_URI="http://people.igalia.com/berto/files/${PN}/source/${PN}_${PV}.orig.tar.gz"

S="${WORKDIR}/${P}.orig"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/libxml2-2.6
	>=net-misc/curl-7.15
	>=media-plugins/gst-plugins-mad-0.10
	>=dev-libs/dbus-glib-0.72
	>=x11-libs/libnotify-0.4
	>=dev-libs/libgcrypt-1.2.4"
RDEPEND="${DEPEND}"

