# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EBZR_SRC_URI="bzr+http://code.connectical.com/comida/bzr/trunk"

inherit bazaar

DESCRIPTION="The Connectical/Common Mirror Daemon"
HOMEPAGE="http://code.connectical.com/comida"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-shells/bash-3.0
	>=net-misc/rsync-2.6
	>=sys-apps/coreutils-6.9
	>=sys-apps/util-linux-2.10
	virtual/cron"
DEPEND=""


src_compile () {
	einfo "Nothing to compile"
}


src_install () {
	dobin comida comida-list

	insinto /etc/comida
	doins etc/comida.conf etc/mirror_defaults.conf

	insinto /etc/comida/mirrors
	doins etc/mirrors/*.conf

	insinto /etc/comida/classes
	doins etc/classes/*

	insinto /etc/comida/parsers
	doins etc/parsers/*.awk

	doenvd "${FILESDIR}/70comida.envd"

	doman man/*
	dodoc doc/cron.example README
}


pkg_postinst () {
	elog
	elog "Example configuration files for setting up Gentoo, Ubuntu and Comida"
	elog "mirrors have been installed into /etc/comida/mirrors, please review"
	elog "configuration before using Comida"
	elog
}

