#!/bin/bash
#
# - mactex-uninstaller
#
# Written by Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>
#
# Note: We want to declare full-permissive license(e.g. WTFPL). But some
#       countries and associations prohibit such kind of manner. Thus we
#       declare it for MIT license.
#
# Copyright & License:
#
# The MIT License (MIT)
#
# Copyright (c) 2014 kusm admin team
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e

print_help(){
    cat <<EOF
= NAME

mactex-uninstaller - simple uninstaller for MacTeX, using pkgutil

= SYNOPSIS

 % mactex-uninstaler

= DESCRIPTION

mactex-uninstaler is is simple shell script in order to set uninstall
MacTeX and BasicTeX bundle, using pkgutil.

= AUTHOR

Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>

EOF
}

if [ $1 ]; then
    print_help
    exit 0
fi

PKGS=(com.tug.mactex.gui2013 \
org.tug.mactex.basictex2013 \
org.tug.mactex.fixmactex2013 \
org.tug.mactex.ghostscript9.05 \
org.tug.mactex.ghostscript9.07 \
org.tug.mactex.gui \
org.tug.mactex.imagemagick-convert-6.7.6-9 \
org.tug.mactex.imagemagick-convert-6.8.3-3 \
org.tug.mactex.texlive2012
)
OLD_IFS=$IFS

export IFS='
'
for (( I=0; I < ${#PKGS[@]}; ++I)) ; do
    PKG=${PKGS[$I]}
    if [ ! -z `pkgutil --pkgs | grep $PKG` ] ;then
	echo "uninstall $PKG"
	VOLUMNE=`pkgutil --info ${PKGS[$I]} | grep volume | awk '{print $2}'`
	LOCATION=`pkgutil --info ${PKGS[$I]} | grep location | awk '{print $2}'`
	FILE_PATH=${VOLUMNE}${LOCATION}
	for f in `pkgutil --files ${PKGS[$I]}` ; do
	    if [ -f ${FILE_PATH}/"$f" ] ; then
	        echo rm -fr ${FILE_PATH}/"$f"
	        sudo rm -fr ${FILE_PATH}/"$f"
	    fi
	done
	sudo pkgutil --forget ${PKGS[$I]}
    fi
done

export IFS=$OLD_IFS
