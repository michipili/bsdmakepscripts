### ocaml.tools.mk -- Pseudo commandes pour CAML

# Author: Micha�l Le Barbier Gr�newald
# Date: Sam  7 jul 2007 20:50:52 CEST
# Lang: fr_FR.ISO8859-1

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

# .include "ocaml.target.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# Ce module d�finit les pseudo-commande MLCB, MLCN, etc. indiqu�es
# dans le tableau ci-dessous.

# MLCB		Compilateur code octet
# MLCN		Compilateur code natif
# MLCI		Compilateur d'interfaces
#                rappelons que les fichiers d'interfaces pr�par�s avec
#                un compilateur peuvent �tre utilis�s avec l'autre.
# MLAB		Facteur d'archives (biblioth�ques) code octet
# MLAN		Facteur d'archives (biblioth�ques) code natif
# MLLB		�diteur de liens code octet
# MLLN		�diteur de liens code natif
# MLPO		Cr�ateur de paquet code octet
# MLPX		Cr�ateur de paquet code natif

.if !target(__<ocaml.tools.mk>__)
__<ocaml.tools.mk>__:

_OCAML_TOOLS+= MLCI MLCB MLCN MLAB MLAN MLLB MLLN MLPO MLPX

MLCB?= ocamlc -c
MLCN?= ocamlopt -c
.if !empty(TARGET:Mbyte_code)
MLCI?= ocamlc -c
.else
MLCI?= ocamlopt -c
.endif
MLAB?= ocamlc -a
MLAN?= ocamlopt -a
MLLB?= ocamlc
MLLN?= ocamlopt
MLPO?= ${MLCB} -pack
MLPX?= ${MLCN} -pack

.endif#!target(__<ocaml.tools.mk>__)

### End of file `ocaml.tools.mk'
