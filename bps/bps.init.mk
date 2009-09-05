### bps.init.mk -- Initialisation pour les modules `make'.

# Author: Micha�l Le Barbier Gr�newald
# Date: Ven 10 f�v 2006 10:40:49 GMT
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Micha�l Le Barbier Gr�newald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


### SYNOPSIS

# .include "bps.init.mk"


### DESCRIPTION

# Rend des services dans le domaine de l'initialisation.
#
# D�finit des pseudo-commandes CP, MV INSTALL, INSTALL_DIR,
# SED_INPLACE, etc.;
#
# D�finit une valeur pour APPLICATIONDIR sur la base de la valeur de
# APPLICATION, si cette derni�re a une valeur.
#
# D�finit des pseudo-commandes WARN, INFO, MESG, FAIL utilis�es pour
# le diagnostique.
#
# D�finit `all' comme cible implicite.
#
# Demande le traitement des fichiers "bps.own.mk" et "bps.clean.mk"
#  et "Makefile.inc".
#
# Demande le traitement du fichier MAKEINITRC si cette variable est
# d�finie et que l'utilisateur courant n'est pas l'utilisateur
# root. Ceci permet d'utiliser le m�me Makefile pour installer des
# programmes `localement', et `globalement' avec la commande `sudo'.
#
# D�finit la liste _MAKE_USERTARGET des cibles ``interface utilisateur''
# (all, clean, etc.). Voici la liste des ces cibles et les actions
# qu'elles doivent entreprendre:
#
#    * obj: cr�er l'arborescence n�cessaire sous `objdir', le cas �ch�ant
#    * configure: traite le code source pour l'adapter �
#       l'environnement courant;
#    * depend: traite le code source pour d�terminer automatiquement
#       les d�pendances entre certaines modules;
#    * build: pr�pare le programme;
#    * doc: pr�pare la documentation;
#    * all: configure, depend, build, doc;
#    * install: installer le programme et la documentation;
#    * clean: nettoie les fichiers produits lors de la pr�paration du
#       programme et de la documentation (y compris le programme et la
#       documentation eux-m�mes);
#    * distclean: comme clean, et nettoie les fichiers produits par
#       les �tapes configure et depend.
#
#  Dans certains cas, il faut interpr�ter tr�s librement le terme
#  `programme' utilis� ci-dessus.

#
# Description des variables
#

# MAKEINITRC
#
#   Fichier d'initialisation pour l'utilisateur.
#
#   Lorsque la variable USER ne vaut pas 'root', lorsque la variable
#   'MAKEINITRC' est d�finie et a comme valeur le nom d'un fichier,
#   ce fichier est lu par make pendant l'�valuation de ce module, apr�s
#   lecture �ventuelle de 'Makefile.inc'.
#
#   Ce m�canisme permet notamment � l'utilisateur de d�finir des valeurs
#   convenables � DESTDIR, BINOWN, etc. pour installer les objets dans
#   son r�pertoire personnel. Le r�le sp�cial de la valeur root permet
#   d'installer les programmes `system-wide' par un simple sudo, sans
#   avoir besoin d'efacer la variable MAKEINITRC.

# CP RM INSTALL INSTALL_DIR AWK SED SED_INPLACE ECHO.
#
#   Pseudo commandes.

# APPLICATION APPLICATIONDIR
#
#   Nom de l'application pr�par�e.
#
#   La variable APPLICATION peut �tre d�finie par le client. Lorsque
#   c'est le cas la Collection de Makefiles en tient compte dans
#   certains endroits, notamment pour donner des noms de r�pertoires
#   cens�s �tre appropri�s. C'est en fait la variable APPLICATIONDIR qui
#   joue ce r�le, on s'en sert par exemple pour d�finir
#   SHAREDIR=/share${APPLICATIONDIR}, etc.
#
#   SeeAlso: bps.own.mk bps.files.mk


### IMPL�MENTATION

.if !target(__<bps.init.mk>__)
__<bps.init.mk>__:

.if exists(bps.config.mk)
.include "bps.config.mk"
.endif

### PSEUDO COMMANDES (BOOTSTRAP)

ID?=			/usr/bin/id
.if !defined(UID)
UID!= ${ID} -u
.endif

.if !defined(USER)
USER!= ${ID} -n -u
.endif

.if !defined(GROUP)
GROUP!= ${ID} -n -g
.endif

## LECTURE DES FICHIERS DE CONFIGURATION

.if exists(${.CURDIR}/Makefile.inc)
.include "${.CURDIR}/Makefile.inc"
.elif exists(../${.CURDIR}/Makefile.inc)
.include "../${.CURDIR}/Makefile.inc"
.elif exists(../../${.CURDIR}/Makefile.inc)
.include "../../${.CURDIR}/Makefile.inc"
.elif exists(../../../${.CURDIR}/Makefile.inc)
.include "../../../${.CURDIR}/Makefile.inc"
.elif exists(../../../../${.CURDIR}/Makefile.inc)
.include "../../../../${.CURDIR}/Makefile.inc"
.endif

.if !(${UID} == 0) && defined(MAKEINITRC) && !empty(MAKEINITRC)
.if exists(${MAKEINITRC})
.include "${MAKEINITRC}"
.endif
.endif

## PSEUDO COMMANDES

ENVTOOL?=		env			# Le nom ENV
                                                #  appartient � sh(1)
CP?=			cp
RM?=			rm
MV?=			mv
LN?=			ln
LN_S?=			ln -s
MKDIR?=			mkdir
TAR?=			tar
INSTALL?=		install
INSTALL_DIR?=		install -d
AWK?=			awk
GREP?=			grep
SED?=			sed
SED_INPLACE?=		${SED} -i .bk
TOUCH?=			touch
ECHO?=			echo
INFO?=			@echo '===>'
WARN?=			@echo 'Warning:'
FAIL?=			@echo 'Failure:'
MESG?=			@echo
NOP?=			@: do nada

### VARIABLES

CLEANFILES?=
CLEANDIRS?=
DISTCLEANFILES?=
DISTCLEANDIRS?=
REALCLEANFILES?=
REALCLEANDIRS?=

## CIBLE IMPLICTE (all)

.MAIN:			all


## APPLICATIONDIR

.if defined(APPLICATION) && !empty(APPLICATION)
APPLICATIONDIR?=	/${APPLICATION}
.endif

## _MAKE_USERTARGET

_MAKE_USERTARGET?=
_MAKE_ALLSUBTARGET?=

.include "bps.own.mk"
.include "bps.objdir.mk"
.include "bps.autoconf.mk"

_MAKE_USERTARGET+= configure depend build doc all install
_MAKE_USERTARGET+= clean distclean realclean
_MAKE_ALLSUBTARGET+= configure depend build doc


#
# H�ritage de certaines variables
#

# Les valeurs des variables DESTDIR et PREFIX sont export�es dans
# l'environnement.

.if empty(.MAKEFLAGS:MPREFIX=*)&&defined(PREFIX)
.MAKEFLAGS: PREFIX='${PREFIX}'
.endif

.if empty(.MAKEFLAGS:MDESTDIR=*)&&defined(DESTDIR)
.MAKEFLAGS: DESTDIR='${DESTDIR}'
.endif

.endif # !target(__<bps.init.mk>__)

### End of file `bps.init.mk'
