### mkheader.sh -- Pr�pare un en-t�te pour un fichier Makefile

# Author: Micha�l Le Barbier Gr�newald
# Date: Ven 14 mar 2008 11:00:31 CET
# Lang: fr_FR.ISO8859-1

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

mkheader_process()
{
if ! [ -e $1 ]; then
    echo "File $1 does not exist." 1>&2
    exit 1
fi

header_ctime=`stat -f '%c' $1`
header_cdate=`date -j -f '%s' $header_ctime`
header_lang=${LANG}
header_author=`pw user show $USER | cut -d: -f 8`

ed -s $1 > /dev/null <<EOF
2
2,/^[^#]/g/^# [A-Z][a-zA-Z]*:/d
2,/^[^#]/g/^# \$Id/d
2,/^[^[:blank:]]/g/^\$/d
2i

# Author: Micha�l Le Barbier Gr�newald
# Date: $header_cdate
# Lang: $header_lang

# \$Id\$

.
w
q
EOF
}

for file in "$@"; do
    mkheader_process $file
done

### End of file `mkheader.sh'
