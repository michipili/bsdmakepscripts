### latex.doc.mk -- Produce LaTeX documents

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

# Confer `tex.doc.mk'.

.include "latex.doc.pre.mk"
.include "tex.doc.mk"
.include "latex.bibtex.mk"
.include "latex.doc.post.mk"

### End of file `latex.doc.mk'