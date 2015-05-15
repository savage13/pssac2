
AC_INIT(pssac2, v3.0.gmt5, savage@uri.edu, pssac2)

AM_MAINTAINER_MODE

AC_CANONICAL_SYSTEM

# Check for LDFLAGS Variable and set default to ""
AS_IF( [ test x"${LDFLAGS}" = x ], [ LDFLAGS="" ] )
AS_IF( [ test x"${CFLAGS}" = x ], [ CFLAGS="" ] )

AC_CONFIG_SRCDIR([./pss.c])

AM_INIT_AUTOMAKE([foreign])

AC_ARG_WITH(gmt, [AS_HELP_STRING([--with-gmt=path],[Specify path to GMT])], 
                 [
                   [ LDFLAGS+=" -L${withval}/lib "] 
                   [ CFLAGS+=" -I${withval}/include  " ]
                 ], [])

AC_PROG_CC
AC_SEARCH_LIBS(sin, m)

AC_CHECK_PROG([GMTCONFIG], [gmt-config], [gmt-config])
test -z "$GMTCONFIG" && AC_MSG_ERROR([Missing GMT5 nstallation.])

AM_PROG_CC_C_O

AC_CONFIG_HEADERS([config.h])

AC_OUTPUT([Makefile t/Makefile])


