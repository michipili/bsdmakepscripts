### latex.bibtex.mk -- Support pour BibTeX

# Author: Micha�l Le Barbier Gr�newald
# Date: Ven 11 jul 2008 22:17:23 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# BSDMake Pall�s Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pall�s Scripts
# 
# Copyright (C) Micha�l Le Barbier Gr�newald - 2008-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# USE_BIBTEX = yes
# .include "latex.bibtex.mk"


### DESCRIPTION

# Si USE_BIBTEX vaut yes, les fichiers auxiliaires associ�s aux
# fichiers objet �num�r�s par les variables _TEX_DVI, _TEX_PS et
# _TEX_PDF sont trait�s avec BIBTEX en vue de la production finale du
# document.
#
# L'�tape de traitement de la base de donn�e prend place entre la
# passe `aux' et la passe `toc' des travaux en plusieurs traitement de
# LaTeX.

# BSTINPUTS
#
#  Chemins de recherche pour les styles de bibliographie.
#
#  Si la variable BSTINPUTS est d�finie, celle-ci est export�e vers
#  l'environnement de la commande BIBTEX. De plus la variable
#  USE_BIBTEX re�oit `yes' pour valeur implicite.

# BIBINPUTS
#
#  Chemins de recherche pour les bases de donn�es bibliographiques.
#
#  Si la variable BIBINPUTS est d�finie, celle-ci est export�e vers
#  l'environnement de la commande BIBTEX. De plus la variable
#  USE_BIBTEX re�oit `yes' pour valeur implicite.


### IMPL�MENTATION

.if !target(__<latex.bibtex.mk>__)
__<latex.bibtex.mk>__:

BIBTEX?= bibtex

#
# Calcul de l'environnement d'�x�cution de la commande BIBTEX
#

_BIBTEX_ENV =

.if defined(BSTINPUTS)
_BIBTEX_ENV+= BSTINPUTS='${BSTINPUTS}'
USE_BIBTEX?= yes
.endif

.if defined(BIBINPUTS)
_BIBTEX_ENV+= BIBINPUTS='${BIBINPUTS}'
USE_BIBTEX?= yes
.endif

.if !empty(_BIBTEX_ENV)
_BIBTEX_CMD = env ${_BIBTEX_ENV} ${BIBTEX}
.else
_BIBTEX_CMD = ${BIBTEX}
.endif

USE_BIBTEX?= no

.if ${USE_BIBTEX} == yes
.for var in _TEX_DVI _TEX_PDF _TEX_PS
.if defined(${var})&&!empty(${var})
.for doc in ${${var}}
${_TEX_COOKIE}${doc:T}.toc: ${_TEX_COOKIE}${doc:T}.bib
${_TEX_COOKIE}${doc:T}.bib: ${_TEX_COOKIE}${doc:T}.aux
	${INFO} 'Processing bibliography database information for ${doc:T}'
	${_BIBTEX_CMD} ${doc:R}
COOKIEFILES+= ${_TEX_COOKIE}${doc:T}.bib
CLEANFILES+= ${doc:R}.bbl
CLEANFILES+= ${doc:R}.blg
.endfor
.endif
.endfor
.endif

.endif # !target(__<latex.bibtex.mk>__)

### End of file `latex.bibtex.mk'
