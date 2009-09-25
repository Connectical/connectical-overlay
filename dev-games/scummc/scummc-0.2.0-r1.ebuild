# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Set of tools to create SCUMM games which run on ScummVM"
HOMEPAGE="http://alban.dotsec.net/Projects/ScummC"
SRC_URI="http://alban.dotsec.net/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE="examples doc gtk freetype sdl"

RDEPEND="sys-apps/less
	sys-apps/coreutils
	>=sys-devel/make-3.80
	gtk? ( >=x11-libs/gtk+-2.4 )
	sdl? ( >=media-libs/libsdl-1.2 )
	freetype? ( >=media-libs/freetype-1.3 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=sys-devel/bison-1.28
	doc? ( app-doc/doxygen )"


src_compile () {
	local opts=""
	use gtk      || opts="${opts} --disable-gtk"
	use sdl      || opts="${opts} --disable-sdl"
	use freetype || opts="${opts} --disable-freetype"
	./configure --buildroot build --cflags "${CFLAGS}" \
		--release ${opts}
	emake all

	if use doc ; then
		emake -j1 dox
		for i in man/*.xml ; do
			ebegin "Generating ${o}"
			local o="${i/.xml/.html}"
			xsltproc man/html.xslt "${i}" > "${o}"
			sed -i -e 's:href="\(.*\)\.xml":href="\1.html":g' "${o}"
			eend $?
		done
	fi
}


src_install () {
	dodoc README

	local binaries="scc sld cost char soun midi zpnn2bmp rd"
	binaries="${binaries} imgsplit imgremap palcat raw2voc scvm"
	use gtk && binaries="${binaries} costview boxedit"

	for i in ${binaries} ; do
		[ -r build/*/"${i}" ] && dobin build/*/"$i"
	done

	if use doc ; then
		dohtml -r docs/html
		dohtml man/*.html man/*.css
	fi

	insinto "/usr/share/${PN}"
	doins scummVars6.s scummVars7.s

	mkdir -p "${D}/usr/share/doc/${P}"
	cp -av examples "${D}/usr/share/doc/${P}"
}


pkg_postinst () {
	elog
	elog "You may want to install a patched ScummVM capable of running"
	elog "ScummC games directly by using the games-engines/scummvm ebuilds"
	elog "included in the connectical-contrib overlay."
	elog
	elog "Happy hacking!"
	elog
}

