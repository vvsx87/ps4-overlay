# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=5.240.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.4.2
inherit ecm plasma.kde.org optfeature

DESCRIPTION="Utility providing information about the computer hardware"
HOMEPAGE="https://userbase.kde.org/KInfoCenter"
SRC_URI+=" https://www.gentoo.org/assets/img/logo/gentoo-3d-small.png -> glogo-small.png"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE="gles2-only usb"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets,gles2-only=]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/solid-${KFMIN}:6
	gles2-only? ( media-libs/mesa[gles2] )
	usb? ( virtual/libusb:1 )
"
RDEPEND="${DEPEND}
	dev-qt/qdbus:*
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-plasma/kde-cli-tools-${PVCUT}:6
	>=kde-plasma/systemsettings-${PVCUT}:6
"
BDEPEND=">=kde-frameworks/kcmutils-${KFMIN}:6"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package usb USB1)
	)

	ecm_src_configure
}

src_install() {
	ecm_src_install

	# TODO: Make this fully obsolete by /etc/os-release
	insinto /etc/xdg
	doins "${FILESDIR}"/kcm-about-distrorc

	insinto /usr/share/${PN}
	doins "${DISTDIR}"/glogo-small.png
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "NFS information module" net-fs/nfs-utils
		optfeature "Samba status information module" net-fs/samba
		optfeature "Vulkan graphics API information module" dev-util/vulkan-tools
		optfeature "advanced CPU information module" sys-apps/util-linux
	fi
	optfeature "Wayland information module" app-misc/wayland-utils
	optfeature "Firmware security module" "app-text/aha sys-apps/fwupd"
	optfeature "OpenGL information module" x11-apps/mesa-progs
	optfeature "PCI devices information module" sys-apps/pciutils
	optfeature "X Server information module" x11-apps/xdpyinfo
	ecm_pkg_postinst
}
