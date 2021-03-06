dnl Process this file with autoconf to produce a configure script.
AC_INIT([bps/Makefile])
AC_CONFIG_AUX_DIR([Library/Autoconf])
AC_CANONICAL_HOST
AC_NEED_BSDMAKE()
AC_PROG_AWK()
AC_PROG_GREP()
AC_PROG_INSTALL()
AC_PROG_LN_S()
AC_PROG_MKDIR_P()
AC_PROG_OCAML()
AC_PROG_SED()
AC_PROG_ID()
AC_SYSTEM_USER()
AC_TAR_COMPRESSION_METHODS([COMPRESS])

#
# Feature control for package managers
#

# Our package can be installed and used even without the following
# programs, nevertheless, it might be useful for packagers and porters
# to let the configure script fail if some programs are not present.

AC_ARG_WITH_PROG([emacs],
  [AS_HELP_STRING([--with-emacs],
    [support for installation of elisp libraries])],
  [EMACS], [emacs])

AC_ARG_WITH_PROG([gpg],
  [AS_HELP_STRING([--with-gpg],
    [support signing of distribution files with GPG])],
  [GPG], [gpg])

AC_ARG_WITH_PROG([gm],
  [AS_HELP_STRING([--with-gm],
    [support conversion of METAPOST pictures to PNG with GraphicsMagick])],
  [GraphicsMagick], [gm])

AC_ARG_WITH([tex],
  [AS_HELP_STRING([--with-tex],
    [support preparation of TeX documents])],
  [AC_NEED_PROG([TeX], [tex])
   AC_NEED_PROG([LaTeX], [latex])
   AC_NEED_PROG([PdfTeX], [pdftex])
   AC_NEED_PROG([dvips], [dvips])
   AC_NEED_PROG([epstopdf], [epstopdf])])

AC_ARG_WITH_PROG([ocaml],
  [AS_HELP_STRING([--with-ocaml],
    [support preparation of OCaml projects])],
  [ocamlc],
  [ocamlc])

AC_ARG_WITH_PROG([findlib],
  [AS_HELP_STRING([--with-findlib],
    [support use of OCaml findlib in OCaml projects])],
  [findlib],
  [ocamlfind])

AC_ARG_WITH_PROG([tidy],
  [AS_HELP_STRING([--with-tidy],
    [support use of tidy to canonise HTML pages])],
  [tidy],
  [tidy])

AC_ARG_WITH_PROG([opensp],
  [AS_HELP_STRING([--with-opensp],
    [support static HTML pages generation with OpenSP])],
  [opensp],
  [onsgmls nsgmls])

AC_ARG_WITH_PROG([noweb],
  [AS_HELP_STRING([--with-noweb],
    [support literate programming with noweb])],
  [noweb],
  [noweb])

AC_ARG_WITH_PROG([sqlite3],
  [AS_HELP_STRING([--with-sqlite3],
    [support running the testsuite, requiring sqlite3])],
  [Sqlite3],
  [sqlite3])

AC_ARG_WITH([credentials],
  [AS_HELP_STRING([--with-credentials],
    [use ARG for credential switch, where ARG is one of su, sudo or no])],
  [case $with_credentials in
    no|su|sudo)
        SWITCH_CREDENTIALS_STRATEGY=$with_credentials
        ;;
    yes)
        SWITCH_CREDENTIALS_STRATEGY=su
        ;;
    *)
        AC_MSG_ERROR([*** $with_credentials: invalid argument for credentials.])
        ;;
    esac;],
  [case $host_os in
    *cygwin*)
        SWITCH_CREDENTIALS_STRATEGY=no
        ;;
    *)
        SWITCH_CREDENTIALS_STRATEGY=su
        ;;
    esac;])

#
# Conditionally enable tests
#

# OCaml findlib.
#
#   OCaml findlib seems not to be available under Cygwin.  We
#   therefore disable tests requiring it under this platform.

AC_HAS_PROG([ocamlfind])
AC_ARG_ENABLE([test-findlib],
  [AS_HELP_STRING([--enable-test-findlib],
    [enable testsuite part requiring findlib])],
  [WITH_TESTSUITE_FINDLIB=${enable_test_findlib}],
  [WITH_TESTSUITE_FINDLIB=${has_ocamlfind}])
AC_SUBST([WITH_TESTSUITE_FINDLIB])


# Emacs
#
#   Support a part of the testsuite requires a recent version of Emacs
#   to run (after 23.2).

AC_SUBST([EMACS])
AC_SUBST([WITH_TESTSUITE_EMACS])

AC_CHECK_PROGS([EMACS], [emacs], [no])
AC_ARG_ENABLE([test-emacs],
  [AS_HELP_STRING([--enable-test-emacs],
    [enable testsuite part requiring emacs])],
  [WITH_TESTSUITE_EMACS=${enable_test_emacs}],
  [if test "${EMACS}" == 'no'; then
    WITH_TESTSUITE_EMACS=no
  else
    WITH_TESTSUITE_EMACS=yes
  fi;])


# Python setup tools
#
#   Support of Python setup tools for preparing Python libraries is an
#   experimental feature.  Corresponding files are always installed
#   but the tests must be explicitly enabled to run.

AC_ARG_ENABLE([test-py-setuptools],
  [AS_HELP_STRING([--enable-test-py-setuptools],
    [enable testsuite part requiring Python setuptools])],
  [WITH_TESTSUITE_PY_SETUPTOOLS=${enable_test_py_setuptools}],
  [WITH_TESTSUITE_PY_SETUPTOOLS=no])


# Mingw32 cross-compiler
#
#   A part of the testsuite requires a Mingw32 cross compiler to
#   complete.  The tests must be explicitly enabled to run.

AC_SUBST([MINGW32AR])
AC_SUBST([MINGW32CC])
AC_SUBST([WITH_TESTSUITE_MINGW32])

AC_CHECK_PROGS([MINGW32CC], [mingw32-gcc i586-mingw32msvc-cc], [no])
AC_CHECK_PROGS([MINGW32AR], [mingw32-ar i586-mingw32msvc-ar], [no])
AC_ARG_ENABLE([test-mingw32],
  [AS_HELP_STRING([--enable-test-mingw32],
    [enable testsuite part requiring a mingw32 cross-compiler])],
  [WITH_TESTSUITE_MINGW32=${enable_test_mingw32}],
  [if test "${MINGW32CC}" == 'no'; then
     WITH_TESTSUITE_MINGW32=no
   else
     WITH_TESTSUITE_MINGW32=yes
   fi;])


# OpenSP
#
#   A part of the testsuite requires a SGML normalizer to
#   complete.  The tests must be explicitly enabled to run.

AC_SUBST([WITH_TESTSUITE_SGMLNORM])
AC_SUBST([SGMLNORM])

AC_CHECK_PROGS([SGMLNORM], [osgmlnorm sgmlnorm], [no])
AC_ARG_ENABLE([test-opensp],
  [AS_HELP_STRING([--enable-test-opensp],
    [enable testsuite part requiring a validating SGML parser])],
  [WITH_TESTSUITE_SGMLNORM=${enable_test_opensp}],
  [if test "${SGMLNORM}" == 'no'; then
     WITH_TESTSUITE_SGMLNORM=no
   else
     WITH_TESTSUITE_SGMLNORM=yes
   fi;])


# Noweb
#
#   A part of the testsuite requires noweb.  The tests must be
#   explicitly enabled to run.

AC_SUBST([WITH_TESTSUITE_NOWEB])

AC_HAS_PROG([noweb])
AC_ARG_ENABLE([test-noweb],
  [AS_HELP_STRING([--enable-test-noweb],
    [enable testsuite part requiring noweb])],
  [WITH_TESTSUITE_NOWEB=${enable_test_noweb}],
  [WITH_TESTSUITE_NOWEB=${has_noweb}])


# GPG
#
#   A part of the testsuite requires gpg to sign archives.  The tests
#   must be explicitly enabled to run.

AC_SUBST([WITH_TESTSUITE_GPG])

AC_HAS_PROG([gpg])
AC_ARG_ENABLE([test-gpg],
  [AS_HELP_STRING([--enable-test-gpg],
    [enable testsuite part requiring gpg])],
  [WITH_TESTSUITE_GPG=${enable_test_gpg}],
  [WITH_TESTSUITE_GPG=${has_gpg}])


# texmf
#
#   A part of the testsuite requires a TeX installation.  The tests
#   must be explicitly enabled to run.

AC_SUBST([WITH_TESTSUITE_TEXMF])

AC_HAS_PROG([tex])
AC_ARG_ENABLE([test-texmf],
  [AS_HELP_STRING([--enable-test-texmf],
    [enable testsuite part requiring texmf])],
  [WITH_TESTSUITE_TEXMF=${enable_test_texmf}],
  [WITH_TESTSUITE_TEXMF=${has_tex}])

# metapost
#
#   The standalone METAPOST tests part can be enabled even
#   if the texmf suite is disabled.
#
#   This is because some Cygwin bug forbids the use of TeX in some
#   conditions, nevertheless, METAPOST seems to continue working.

AC_SUBST([WITH_TESTSUITE_METAPOST])

AC_ARG_ENABLE([test-metapost],
  [AS_HELP_STRING([--enable-test-metapost],
    [enable testsuite for standalone METAPOST documents])],
  [WITH_TESTSUITE_METAPOST=${enable_test_metapost}],
  [WITH_TESTSUITE_METAPOST=${WITH_TESTSUITE_TEXMF}])


# unpack_ocaml_version
#
#   Prepare a string holding OCamlversion
#
# This change the version so that numerical comparison is possible.

unpack_ocaml_version[]()
{
    echo ${OCAMLVERSION} | awk -F. '{printf("%04d%04d%04d", $1, $2, $2)}'
}


AC_SUBST([SWITCH_CREDENTIALS_STRATEGY])
AC_SUBST([WITH_TESTSUITE_PY_SETUPTOOLS])
AC_SUBST([OCAMLVERSION], [$(unpack_ocaml_version)])
AC_SUBST([VERSION], [$(sed -n -e '/^VERSION/s/VERSION=[[:space:]]*//p')])
AC_CONFIG_FILES([Makefile.config bps/bps.bpsconfig.mk])
AC_OUTPUT

cat <<EOF

** Configuration Summary **

Optional Features:
  --enable-test-emacs=${WITH_TESTSUITE_EMACS}
  --enable-test-findlib=${WITH_TESTSUITE_FINDLIB}
  --enable-test-py-setuptools=${WITH_TESTSUITE_PY_SETUPTOOLS}
  --enable-test-mingw32=${WITH_TESTSUITE_MINGW32}
  --enable-test-noweb=${WITH_TESTSUITE_NOWEB}
  --enable-test-gpg=${WITH_TESTSUITE_GPG}
  --enable-test-opensp=${WITH_TESTSUITE_SGMLNORM}
  --enable-test-texmf=${WITH_TESTSUITE_TEXMF}
  --enable-test-metapost=${WITH_TESTSUITE_METAPOST}

Optional Packages:
  --with-credentials=${SWITCH_CREDENTIALS_STRATEGY}

EOF
