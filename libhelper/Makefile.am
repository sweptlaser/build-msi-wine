lib_LTLIBRARIES = libhelper.la

AM_LDFLAGS = \
	-no-undefined

libhelper_la_SOURCES = \
	helper.c

libhelper_la_LIBADD = \
	@MSI_LDADD@

libhelper_la_CFLAGS = \
	-fvisibility=hidden \
	$(AM_CFLAGS)

libhelper_la_LDFLAGS = \
	-shared \
	-avoid-version \
	$(AM_LDFLAGS)

