# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_QTHELP="false"
ECM_TEST="true"
PVCUT=$(ver_cut 1-2)
QTMIN=4.6.2
VIRTUALX_REQUIRED="test" # bug 910062 (tests fail)
inherit ecm frameworks.kde.org

DESCRIPTION="QtQuick plugin providing high-performance charts"
HOMEPAGE="https://invent.kde.org/frameworks/kquickcharts"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	examples? (
		>=dev-qt/qtbase-${QTMIN}:6[widgets]
		=kde-frameworks/kdeclarative-${PVCUT}*:6
		=kde-frameworks/kirigami-${PVCUT}*:6
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
	)

	ecm_src_configure
}