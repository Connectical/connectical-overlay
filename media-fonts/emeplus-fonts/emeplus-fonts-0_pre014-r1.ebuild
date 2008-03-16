# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

MY_P="emeplus-${PV/0_pre/TESTFLIGHT-}"
MY_PR="emeplus-${PVR/0_pre/TESTFLIGHT-}"

DESCRIPTION="Emeplus Japanese outline fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="http://www.connectical.com/distfiles/${PN}/${MY_PR}.tar.bz2"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="README_J"

