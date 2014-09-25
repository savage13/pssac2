
AC_INIT(pssac2, v3.0.gmt5, savage@uri.edu, pssac2)

AM_MAINTAINER_MODE

AC_CANONICAL_SYSTEM

# Check for LDFLAGS Variable and set default to ""
AS_IF( [ test x"${LDFLAGS}" = x ], [ LDFLAGS="" ] )
AS_IF( [ test x"${CFLAGS}" = x ], [ CFLAGS="" ] )

AC_CONFIG_SRCDIR([./pss.c])

AM_INIT_AUTOMAKE

AC_ARG_WITH(gmt, [AS_HELP_STRING([--with-gmt=path],[Specify path to GMT])], 
                 [
                   [ LDFLAGS+=" -L${withval}/lib "] 
                   [ CFLAGS+=" -I${withval}/include  " ]
                 ], [])
AC_ARG_WITH(netcdf, [AS_HELP_STRING([--with-netcdf=path],
                    [Specify path to NetCDF])], 
                    [ 
                      [ LDFLAGS+=" -L${withval}/lib " ]
                      [ CFLAGS+=" -I${withval}/include " ] 
                    ], [])

AC_PROG_CC
AC_SEARCH_LIBS(sin, m)
#AC_SEARCH_LIBS(nc_create, netcdf, [], [AC_MSG_ERROR([NetCDF library not found])])
AC_SEARCH_LIBS(GMT_Create_Session, gmt,    [], [AC_MSG_ERROR([GMT library not found])])
#AC_SEARCH_LIBS(ps_line,   psl,    [  ], [
#    AC_SEARCH_LIBS(PSL_plotline,   psl,    [ ], [AC_MSG_ERROR([PSL library not found])])
#])
#AC_SEARCH_LIBS(GMT_putfill,  gmt,  [], [AC_MSG_ERROR([gmtps library not found])])
AM_PROG_CC_C_O

AC_CONFIG_HEADERS([config.h])

AC_OUTPUT([Makefile t/Makefile])


