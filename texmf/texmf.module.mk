### texmf.module.mk -- Take in account other modules in the project

# Author: Michael Grünewald
# Date: Mon Nov 24 14:01:15 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !defined(THISMODULE)
.error texmf.module.mk cannot be included directly.
.endif

.if !target(__<texmf.module.mk>__)
__<texmf.module.mk>__:

.endif # !target(__<texmf.module.mk>__)

### End of file `texmf.module.mk'