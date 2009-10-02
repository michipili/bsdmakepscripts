### rox.template.mk

# Author: Micha�l Le Barbier Gr�newald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pall�s Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pall�s Scripts
# 
# Copyright (C) Micha�l Le Barbier Gr�newald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


.if !target(__<rox.template.mk>__)
__<rox.template.mk>__:

.include "bps.init.mk"
.include "rox.init.mk"

TEMPLATEMODE?=	${SHAREMOD}
TEMPLATEDIR?=	${ROXCONFIGDIR}/Template

FILESGROUPS+=TEMPLATE
.include "bps.files.mk"

.endif#!target(__<rox.template.mk>__)

### End of file `rox.template.mk'
