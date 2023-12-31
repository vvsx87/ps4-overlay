# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=VulkanTools
PYTHON_COMPAT=( python3_{9..12} )
inherit cmake-multilib python-any-r1 xdg-utils

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/LunarG/${MY_PN}.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/LunarG/${MY_PN}/archive/sdk-${PV}.0.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv"
	S="${WORKDIR}"/${MY_PN}-sdk-${PV}.0
fi

DESCRIPTION="Official Vulkan Tools and Utilities for Windows, Linux, Android, and MacOS"
HOMEPAGE="https://github.com/LunarG/VulkanTools"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="wayland +X"

# Cube demo only supports one window system at a time
#REQUIRED_USE="cube? ( ^^ ( X wayland ) )"

#BDEPEND="${PYTHON_DEPS}
#	cube? ( ~dev-util/glslang-${PV}:=[${MULTILIB_USEDEP}] )
#"

# minimum Qt version required
QT_PV="5.15.2:5"

RDEPEND="
	~media-libs/vulkan-loader-${PV}:=[${MULTILIB_USEDEP},wayland?,X?]
	wayland? ( dev-libs/wayland:=[${MULTILIB_USEDEP}] )
	X? (
		x11-libs/libX11:=[${MULTILIB_USEDEP}]
		x11-libs/libXrandr:=[${MULTILIB_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	~dev-util/vulkan-headers-${PV}
	~media-libs/vulkan-layers-${PV}
	>=dev-libs/jsoncpp-1.9.5
	>=dev-cpp/valijson-1.0
	>=dev-qt/qtcore-${QT_PV}
        >=dev-qt/qtgui-${QT_PV}
        >=dev-qt/qtwidgets-${QT_PV}
        >=dev-qt/qtnetwork-${QT_PV}
"

pkg_setup() {
	MULTILIB_CHOST_TOOLS=(
		/usr/bin/vkconfig
	)

#	use cube && MULTILIB_CHOST_TOOLS+=(
#		/usr/bin/vkcube
#		/usr/bin/vkcubepp
#	)

	python-any-r1_pkg_setup
}

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS="${CFLAGS} -DNDEBUG"
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DNDEBUG"
		-DCMAKE_SKIP_RPATH=ON
#		-DBUILD_VULKANINFO=ON
#		-DBUILD_CUBE=$(usex cube)
		-BUILD_VKJSON=ON
		-DBUILD_WERROR=OFF
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
		-Dvalijson_DIR="${ESYSROOT}/usr/lib64/cmake/valijson"
		-DVULKAN_HEADERS_INSTALL_DIR="${ESYSROOT}/usr"
		-DVULKAN_LOADER_INSTALL_DIR="${ESYSROOT}/usr"
		-DVULKAN_VALIDATIONLAYERS_INSTALL_DIR="${ESYSROOT}/usr"
	)

#	use cube && mycmakeargs+=(
#		-DGLSLANG_INSTALL_DIR="${ESYSROOT}/usr"
#		-DCUBE_WSI_SELECTION=$(usex X XCB WAYLAND)
#	)

	cmake_src_configure
}
