# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.240.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.4.2
inherit ecm plasma.kde.org

DESCRIPTION="Integrate Chrome/Firefox better into Plasma through browser extensions"
HOMEPAGE+=" https://community.kde.org/Plasma/Browser_Integration"

LICENSE="GPL-3+"
SLOT="6"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[X,dbus,gui,widgets]
	>=kde-frameworks/kactivities-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/purpose-${KFMIN}:6
	>=kde-plasma/plasma-workspace-${PVCUT}:6
"
DEPEND="${RDEPEND}
	>=kde-frameworks/krunner-${KFMIN}:6
"

src_configure() {
	local mycmakeargs=(
		-DMOZILLA_DIR="${EPREFIX}/usr/$(get_libdir)/mozilla"
	)

	ecm_src_configure
}