#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])
AC_INIT([packaging], [1.0], [support@sweptlaser.com])
AC_CONFIG_MACRO_DIR([m4])

AC_CONFIG_SRCDIR([helper.c])
AC_CONFIG_HEADERS([config.h])
AC_LANG(C)

TOPSRCDIR="\${abs_top_srcdir}"
TOPBLDDIR="\${abs_top_builddir}"
EXTRA_CFLAGS="-I${TOPSRCDIR}/include"
EXTRA_LDADD="-L${TOPBLDDIR}/src/"

# Setup the library search path for architecture-specific files
IS_X64=no
case "$host" in
	x86_64-*)
		IS_X64=yes
	;;
esac
if test "x$IS_X64" != "xno"; then
	EXTRA_LIBADD="-L${TOPSRCDIR}/lib64"
else
	EXTRA_LIBADD="-L${TOPSRCDIR}/lib32"
fi

# Add OS-specific libraries to the link list
IS_WIN=no
case "$host" in
	*-mingw32*)
		CC="$host-gcc"
		IS_WIN=yes
	;;
esac
if test "x$IS_WIN" != "xno"; then
	lt_cv_deplibs_check_method=pass_all
	MSI_LDADD="-L${TOPSRCDIR}/deps/ -lmsi"
	AC_SUBST(MSI_LDADD)
fi

AM_INIT_AUTOMAKE([foreign])
LT_INIT([disable-static] [win32-dll] [disable-static])

AC_PROG_CC

# Checks for optional (platform-dependent) header files
AC_CHECK_HEADERS([ \
	dlfcn.h \
	sys/ioctl.h \
	sys/types.h \
	windows.h \
])

AC_CONFIG_FILES([Makefile])

AC_OUTPUT
