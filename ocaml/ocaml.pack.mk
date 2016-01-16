### ocaml.pack.mk -- Building OCaml packed modules

# Author: Michael Grünewald
# Date: Tue Apr  5 12:31:04 CEST 2005

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# PACK=		minibasic
# SRCS=		main.ml
# SRCS+=	basic_types.ml
# SRCS+=	basic_parser.mly
# SRCS+=	basic_lexer.mll
#
# .include "ocaml.pack.mk"


### DESCRIPTION

# Build an OCaml packed module as with the `-pack` options of the
# compiler.
#
# It supports building bytecode and native libraries, ocamlfind,
# lexers and parsers generated by ocamllex and ocamlyacc and
# debugging, profiling as well.

#  PACK
#   Name of the packed module
#
#   This can actually be a list of packed modules.  In this case for
#   each `module` a variable `SRCS.module` should specify files that
#   will be part of the packed `module`.
#
#
#  SRCS
#   Files that must be compiled
#
#   It can list implementation files, interface files, lexer and
#   parser definitions. It is not necessary to specify interface file
#   if an implementation is present.
#
#   For each packed `module`, if there is an interface file
#   `${module}.mli`, it is compiled and used.
#
#
#  DIRS
#   Directories that are searched for libraries or compiled modules
#
#
#  PKGS
#   OCamlfind packages that are used
#
#
#  LIBOWN, LIBGRP, LIBMODE, LIBDIR, LIBNAME
#   Parameters of the module installation
#
#   See `bps.own.mk` for a closer description of these variables.

THISMODULE=		ocaml.pack
PRODUCT=		${PACK}
_PACKAGE_CANDIDATE=	${PACK}

.if !defined(PACK)||empty(PACK)
.error The ocaml.pack.mk module expects you to set the PACK variable to a sensible value.
.endif

.include "ocaml.init.mk"

_OCAML_SRCS?=
_OCAML_CMA?=
_OCAML_CMXA?=
_OCAML_A?=

_OCAML_PACK:=${PACK}
_OCAML_CAPITALISED_PACK!= awk -v pack="${_OCAML_PACK}" 'BEGIN{print(toupper(substr(pack,1,1)) substr(pack,2));exit}'

OCAMLCNFLAGS+= -for-pack ${_OCAML_CAPITALISED_PACK}

#
# Prepare source lists
#

.for pack in ${_OCAML_PACK}
SRCS.${pack:T}?=${SRCS}
.if exists(${pack:T}.mli)
_OCAML_CMI+=${pack:T}.cmi
${pack:T}.cmo: ${pack:T}.cmi
${pack:T}.cmx: ${pack:T}.cmi
.elif !target(${pack:T}.cmi)
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
${pack:T}.cmi: ${pack:T}.cmx
	${NOP}
.else
${pack:T}.cmi: ${pack:T}.cmo
	${NOP}
.endif
.endif
.if defined(_OCAML_COMPILE_NATIVE)
SRCS.${pack:T}.cmx?=${SRCS.${pack:T}}
SRCS.${pack:T}.cmxa?=${pack}.cmx
_OCAML_SRCS+=SRCS.${pack}.cmx
_OCAML_CMXA+=${pack:T}.cmxa
_OCAML_PKX+=${pack:T}.cmx
_OCAML_A+=${pack:T}.a
.endif
.if defined(_OCAML_COMPILE_BYTE)
SRCS.${pack:T}.cmo?=${SRCS.${pack:T}}
SRCS.${pack:T}.cma?=${pack}.cmo
_OCAML_SRCS+=SRCS.${pack}.cmo
_OCAML_CMA+=${pack:T}.cma
_OCAML_PKO+=${pack:T}.cmo
.endif
.endfor


#
# Define build targets
#

.include "ocaml.main.mk"


#
# Epilogue,
#  installation groups and product cleaning
#

.for pack in ${_OCAML_PACK}
.if defined(_OCAML_COMPILE_NATIVE)
LIB+= ${pack}.cmxa ${pack}.a
_OCAML_SRCS.${pack}.cmx=${.ALLSRC}
_OCAML_SRCS.${pack}.cmxa=${.ALLSRC}
${pack}.cmx: ${SRCS.${pack:T}.cmx:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
${pack}.cmxa: ${pack}.cmx
.endif
.if defined(_OCAML_COMPILE_BYTE)
LIB+= ${pack}.cma
_OCAML_SRCS.${pack}.cmo=${.ALLSRC}
_OCAML_SRCS.${pack}.cma=${.ALLSRC}
${pack}.cmo: ${SRCS.${pack:T}.cmo:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
${pack}.cma: ${pack}.cmo
.endif
LIB+= ${pack}.cmi
.endfor

LIBDIR=${PREFIX}/lib/ocaml${PACKAGEDIR}

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.pack.mk'
