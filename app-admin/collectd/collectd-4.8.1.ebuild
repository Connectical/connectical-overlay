# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

I_KNOW_WHAT_I_AM_DOING=1

inherit eutils
inherit linux-info
inherit java-pkg-opt-2

DESCRIPTION="A small daemon to collect system statistics into RRD files."
HOMEPAGE="http://collectd.org/"
SRC_URI="http://collectd.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lm_sensors mysql perl orace apcups ascent acpi curl bind
	  dbi dns email exec hddtemp iptables ipmi ipvs libvirt mbmon
	  memcached multimeter netlink nginx apache ntp nut onewire openvpn
	  postgres powerdns rrdtool rrdcached snmp teamspeak2 vserver wireless
	  uuid notify notify_email memcachec java conntrack ntp nfs fscache
	  table protocols ted ping"

DEPEND="
	ping? ( net-libs/liboping )
	memcachec? ( dev-libs/libmemcached )
	java? ( >=virtual/jdk-1.5 )
	nut? ( sys-power/nut )
	postgres? ( dev-db/libpq )
	dns? ( virtual/libpcap )
	notify? ( x11-libs/libnotify )
	snmp? ( net-analyzer/net-snmp )
	ipmi? ( sys-libs/openipmi )
	bind? ( net-misc/curl
			dev-libs/libxml2 )
	libvirt? ( app-emulation/libvirt
			   dev-libs/libxml2 )
	ascent?  ( dev-libs/libxml2 )
	nginx? ( net-misc/curl )
	curl? ( net-misc/curl )
	apache? ( net-misc/curl )
	rrdtool? ( >=net-analyzer/rrdtool-1.2 )
	rrdcached? ( >=net-analyzer/rrdtool-1.3 )
	onewire? ( sys-fs/owfs )
	memcached? ( dev-libs/libmemcached )
	hddtemp? ( app-admin/hddtemp )
	lm_sensors? ( >=sys-apps/lm_sensors-2.9.0 )
	mysql? ( >=dev-db/mysql-4.1 )
	perl? ( sys-devel/libperl )
	apcups? ( dev-db/libdbi )
	uuid? ( sys-apps/hal )
	iptables? ( net-firewall/iptables )
	netlink? ( net-libs/libnfnetlink )
	notify_email? ( net-libs/libesmtp )
	"
RDEPEND=${DEPEND}

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/ut_check_notification.patch"
	epatch "${FILESDIR}/fix_okay_notification.patch"
}

src_compile() {

	if use perl ; then
		if ! built_with_use sys-devel/libperl ithreads; then
			die $"sys-devel/libperl is not compile with USE ithreads" \
				$"You need to recompile sys-devel/libperl with ithreads support"
		fi
	fi

	if use ipvs ; then
		require_configured_kernel
		linux_chkconfig_present IP_VS || \
		die $"kernel do not support IP virtual server," \
			$"required for ipvs plugin"
	fi

	if use conntrack ; then
		require_configured_kernel
		linux_chkconfig_present NF_CONNTRACK || \
		die $"kernel do not support Netfilter Conntrack," \
			$"required for conntrack plugin"
	fi

	if use java ; then
		opt_java="--with-java=${JAVA_HOME}"
	fi

	econf --disable-all \
		$(use_enable lm_sensors sensors) $(use_enable mysql) \
		$(use_enable perl) $(use_enable nut) $(use_enable iptables) \
		$(use_enable postgres postgresql) $(use_enable dns) \
		$(use_enable notify notify_desktop) $(use_enable snmp) \
		$(use_enable ipmi) $(use_enable bind) $(use_enable libvirt) \
		$(use_enable ascent) $(use_enable nginx) $(use_enable curl) \
		$(use_enable apache) $(use_enable rrdtool) $(use_enable rrdcached) \
		$(use_enable onewire) $(use_enable memcached) $(use_enable hddtemp) \
		$(use_enable apcups) $(use_enable uuid) $(use_enable netlink) \
		$(use_enable memcachec) $(use_enable conntrack) $(use_enable ntp ntpd) \
		$(use_enable nfs) $(use_enable notify_email) $(use_enable fscache) \
		$(use_enable table) $(use_enable protocols) $(use_enable ping) \
		$(use_enable ted) $opt_java
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO

	docinto contrib
	dodoc contrib/*

	keepdir /var/lib/collectd

	newinitd "${FILESDIR}/${PN}.initd" collectd
	newconfd "${FILESDIR}/${PN}.confd" collectd

#	insinto /etc
#	newins "${FILESDIR}/${PN}.conf" collectd.conf
	keepdir /etc/collectd.d
}

pkg_postinst() {
	einfo "collectd introduced some changes in the new 4.x series."
	einfo "For further information, read http://collectd.org/migrate-v3-v4.shtml"
	einfo "The migration script can be found at:"
	einfo "/usr/share/doc/${P}/contrib/migrate-3-4.px.bz2"

	# while onewire experimental; do
	if use onewire; then
		ewarn "The Onewire plugin is experimental."
		ewarn "Read carefully warn comments in collectd.conf(5) man page"
	fi
}
