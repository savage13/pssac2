
AUTOMAKE_OPTIONS = no-dependencies

GMT_CFLAGS = `${GMTCONFIG} --cflags`
AM_CFLAGS = -Wall -Wextra $(GMT_CFLAGS)

GMT_LIBS = `${GMTCONFIG} --libs`
LIBS += $(GMT_LIBS)

bin_PROGRAMS = pssac2

pssac2_SOURCES = pss.c jb.c sacio.c array.c gmt_support.c clip.c

EXTRA_DIST = sac.h jb.h array.h gmt_support.h

SUBDIRS = t
