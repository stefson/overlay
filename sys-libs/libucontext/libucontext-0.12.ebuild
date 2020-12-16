# Copyright 2018-2020 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="library which provides the <ucontext.h> C API from older POSIX revisions"
HOMEPAGE="https://github.com/kaniini/libucontext"
KEYWORDS="~aarch64 ~amd64 ~arm ~x86"
LICENSE="MIT"
SRC_URI="https://github.com/kaniini/libucontext/archive/${P}.tar.gz"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	default

	sed -i \
		-e 's;^LIBUCONTEXT_PATH = ;\0 /usr;' \
		-e 's;^LIBUCONTEXT_STATIC_PATH = ;\0 /usr;' \
		-e 's;ln -sf ${LIBUCONTEXT_SONAME} ${DESTDIR};\0/usr;' \
		"${S}/Makefile" || die "Failed adjusting prefix to /usr"
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${ED}" install
}
