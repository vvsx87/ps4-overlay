# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_QTHELP="false"
PVCUT=$(ver_cut 1-2)
QTMIN=6.4.2
inherit ecm frameworks.kde.org

DESCRIPTION="Framework for embedding scripting into applications"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[widgets,xml,gui]
	>=dev-qt/qtscript-${QTMIN}:6
	=kde-frameworks/kcompletion-${PVCUT}*:6
	=kde-frameworks/kcoreaddons-${PVCUT}*:6
	=kde-frameworks/ki18n-${PVCUT}*:6
	=kde-frameworks/kiconthemes-${PVCUT}*:6
	=kde-frameworks/kio-${PVCUT}*:6
	=kde-frameworks/kparts-${PVCUT}*:6
	=kde-frameworks/kwidgetsaddons-${PVCUT}*:6
	=kde-frameworks/kxmlgui-${PVCUT}*:6
"
DEPEND=${RDEPEND}