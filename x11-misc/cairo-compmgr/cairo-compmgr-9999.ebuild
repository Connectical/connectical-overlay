# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="http://gandalfn.club.fr/git/cairo-compmgr"
EGIT_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

inherit gnome2 git

DESCRIPTION="A X11 compositing manager which uses Cairo for rendering"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/cairo-1.4.12
	>=x11-libs/libXrender-0.9.2
	>=x11-libs/gtk+-2.10
	>=x11-libs/pixman-0.9.6
	>=media-libs/glitz-0.5.6
	>=x11-proto/glproto-1.4.9
	>=gnome-base/gconf-2.18"
RDEPEND="${DEPEND}"

