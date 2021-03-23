# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="Qt-based, free and open source note-taking application, focusing on Markdown"
HOMEPAGE="https://vnotex.github.io/vnote"
VTEXTEDIT_COMMIT="c86f8bfbf6140b67290ca9229f1145dba5bfc092"
SYNTAX_COMMIT="0f63ff8ce3f7135ffafd62bc464c355960f56cfd"
MY_PV="3.0.0-beta.10"
SRC_URI="
	https://github.com/vnotex/vnote/archive/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
	https://codeload.github.com/vnotex/vtextedit/tar.gz/${VTEXTEDIT_COMMIT} -> vtextedit-${MY_PV}.tar.gz
	https://codeload.github.com/vnotex/syntax-highlighting/tar.gz/${SYNTAX_COMMIT} -> vnotex-syntax-highlighting-${MY_PV}.tar.gz
"

KEYWORDS=""

LICENSE="MIT"
SLOT="0"

DEPEND="
	>=dev-qt/qtcore-5.15.1:5=
	>=dev-qt/qtwebengine-5.15.1:5=
	>=dev-qt/qtsvg-5.15.1:5=
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup(){
	export INSTALL_ROOT="${D}"
}

src_unpack() {
	default
	mv "${WORKDIR}/vtextedit-${VTEXTEDIT_COMMIT}"/* "${S}/libs/vtextedit" || die
	mv "${WORKDIR}/syntax-highlighting-${SYNTAX_COMMIT}"/* "${S}/libs/vtextedit/src/libs/syntax-highlighting" || die
}

src_configure(){
	eqmake5 vnote.pro
}