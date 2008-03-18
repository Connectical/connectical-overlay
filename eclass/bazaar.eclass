# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Adrian Perez <acastro@connectical.org>
# Purpose: The Bazaar eclass allows for getting sources out of Bazaar-NG
#          repositories, like the Subversion and CVS eclasses.
#

inherit eutils

ECLASS="bazaar"
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_unpack

HOMEPAGE="http://bazaar-vcs.org"
DESCRIPTION="Based on the ${ECLASS} eclass"

DEPEND="dev-util/bzr"

EBZR_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/bzr-src"
EBZR_FETCH_CMD="bzr get"
EBZR_UPDATE_CMD="bzr pull"

[ -z "${EBZR_PATCHES}" ] && EBZR_PATCHES=""
[ -z "${EBZR_OPTIONS}" ] && EBZR_OPTIONS=""
[ -z "${EBZR_SRC_URI}" ] && EBZR_SRC_URI=""
[ -z "${EBZR_PROJECT}" ] && EBZR_PROJECT="${PN/-bzr}"
[ -z "${EBZR_BOOTSTRAP}" ] && EBZR_BOOTSTRAP=""


bazaar_bzr_fetch()
{
	local ebzr_co_dir

	[ -z "${EBZR_SRC_URI}" ] && die "${ECLASS}: EBZR_SRC_URI is empty"

	if [ ! -d "${EBZR_STORE_DIR}" ] ; then
		debug-print "${FUNCNAME}: initial checkout, creating storedir"
		addwrite /
		mkdir -p "${EBZR_STORE_DIR}" || \
			die "${ECLASS}: can't mkdir ${EBZR_STORE_DIR}"
		chmod -f o+rw "${EBZR_STORE_DIR}" || \
			die "${ECLASS}: can't chmod ${EBZR_STORE_DIR}"
	fi

	cd -P "${EBZR_STORE_DIR}" || die "${ECLASS}: cannot cd to store dir"

	addwrite "${EBZR_STORE_DIR}"

	EBZR_HOME="${EBZR_STORE_DIR}"

	addwrite ${EBZR_HOME}/.bazaar
	addwrite ${EBZR_HOME}/.bzr.log

	EBZR_CO_DIR="${EBZR_PROJECT}/${EBZR_SRC_URI//\//_}"

	if [ ! -d "${EBZR_CO_DIR}/.bzr" ] ; then
		# first checkout
		einfo "bazaar repository checkout start -->"
		einfo "    repository: ${EBZR_SRC_URI}"

		mkdir -p "${EBZR_PROJECT}" || \
			die "${ECLASS}: can't mkdir ${EBZR_PROJECT}"
		chmod -f o+rw "${EBZR_PROJECT}" || \
			die "${ECLASS}: can't chmod ${EBZR_PROJECT}"
		cd "${EBZR_PROJECT}"

		HOME=${EBZR_HOME} ${EBZR_FETCH_CMD} ${EBZR_OPTIONS} \
			"${EBZR_SRC_URI}" "${EBZR_SRC_URI//\//_}" \
			|| die "${ECLASS}: cant' fetch from ${EBZR_SRC_URI}"
	else
		einfo "bazaar repository update start -->"
		einfo "    repository: ${EBZR_SRC_URI}"

		cd "${EBZR_CO_DIR}"
		HOME=${EBZR_HOME} ${EBZR_UPDATE_CMD} ${EBZR_OPTIONS} || \
			die "${ECLASS}: can't update from ${EBZR_SRC_URI}"
	fi

	einfo "    working copy: ${EBZR_STORE_DIR}/${EBZR_STORE_DIR}"
	rsync -rlpgo --exclude=".bzr" "${EBZR_STORE_DIR}/${EBZR_CO_DIR}/" "${S}" \
		|| die "${ECLASS}: can't export to ${S}"
}


bazaar_src_unpack()
{
	bazaar_bzr_fetch || die "unknown problem in bazaar_bzr_fetch()"
}

