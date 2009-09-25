inherit git

EGIT_REPO_URI="git://repo.or.cz/pywebkitgtk.git"

DESCRIPTION="Python bindings for WebKit on GTK"
HOMEPAGE="http://live.gnome.org/PyWebKitGtk"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.4 >=net-libs/webkit-gtk-0_p31535"
# I have no idea which version of Python this needs.

src_compile() {
	./autogen.sh prefix=/usr
		# default prefix is /usr/local
		# Gentoo python modules are in /usr
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

