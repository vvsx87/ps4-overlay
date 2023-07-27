# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="optional"
KFMIN=6.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.0
inherit ecm plasma.kde.org optfeature

DESCRIPTION="Flexible, composited Window Manager for windowing systems on Linux"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="accessibility caps gles2-only lock multimedia plasma screencast"

RESTRICT="test"

COMMON_DEPEND="
	>=dev-libs/libinput-1.19
	>=dev-libs/wayland-1.21.0
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtwayland-${QTMIN}:6
	>=kde-frameworks/kactivities-${KFMIN}:6
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6[qml]
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6=[X]
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kidletime-${KFMIN}:6=
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwayland-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6=[X]
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/plasma-${KFMIN}:6
	>=kde-plasma/breeze-${PVCUT}:6
	>=kde-plasma/kdecoration-${PVCUT}:6
	media-libs/fontconfig
	media-libs/freetype
	media-libs/lcms:2
	media-libs/libepoxy
	media-libs/libglvnd
	>=media-libs/mesa-21.3[egl(+),gbm(+),wayland,X]
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libXi
	>=x11-libs/libdrm-2.4.112
	>=x11-libs/libxcb-1.10
	>=x11-libs/libxcvt-0.1.1
	>=x11-libs/libxkbcommon-1.5.0
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	accessibility? ( media-libs/libqaccessibilityclient:6 )
	caps? ( sys-libs/libcap )
	gles2-only? ( media-libs/mesa[gles2] )
	lock? ( >=kde-plasma/kscreenlocker-${PVCUT}:6 )
	plasma? ( >=kde-frameworks/krunner-${KFMIN}:6 )
	screencast? ( >=media-video/pipewire-0.3:= )
"
RDEPEND="${COMMON_DEPEND}
	!kde-plasma/kwayland-server
	>=dev-qt/qtquickcontrols-${QTMIN}:6
	>=dev-qt/qtquickcontrols2-${QTMIN}:6
	>=dev-qt/qtvirtualkeyboard-${QTMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6[qml]
	sys-apps/hwdata
	x11-base/xwayland
	multimedia? ( >=dev-qt/qtmultimedia-${QTMIN}:6[gstreamer,qml] )
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/plasma-wayland-protocols-1.9
	>=dev-libs/wayland-protocols-1.31
	>=dev-qt/qtbase-${QTMIN}:6[designer]
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	x11-base/xorg-proto
"
BDEPEND="
	dev-util/wayland-scanner
	>=kde-frameworks/kcmutils-${KFMIN}:6
"
PDEPEND=">=kde-plasma/kde-cli-tools-${PVCUT}:6"

src_prepare() {
	ecm_src_prepare
	use multimedia || eapply "${FILESDIR}/${PN}-5.26.80-gstreamer-optional.patch"

	# TODO: try to get a build switch upstreamed
	if ! use screencast; then
		sed -e "s/^pkg_check_modules.*PipeWire/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		# KWIN_BUILD_NOTIFICATIONS exists, but kdeclarative still hard-depends on it
		$(cmake_use_find_package accessibility QAccessibilityClient)
		$(cmake_use_find_package caps Libcap)
		-DKWIN_BUILD_SCREENLOCKER=$(usex lock)
		$(cmake_use_find_package plasma KF6Runner)
	)

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst
	optfeature "color management support" x11-misc/colord
	elog
	elog "In Plasma 6, default behavior of the Task Switcher to move minimised"
	elog "windows to the end of the list was changed so that it remains in the"
	elog "original order. To revert to the well established behavior:"
	elog
	elog " - Edit ~/.config/kwinrc"
	elog " - Find [TabBox] section"
	elog " - Add \"MoveMinimizedWindowsToEndOfTabBoxFocusChain=true\""
}
