#!/bin/sh
#
# - fix_homebrew_permission_for_multiuser
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

fix_homebrew_permission_for_multiuser - grant all permission for staff group

= SYNOPSIS

 % sudo fix_homebrew_permission_for_multiuser

or

 # fix_homebrew_permission_for_multiuser

= DESCRIPTION

fix_homebrew_permission_for_multiuser is simple shell script in order
to grant permission related homebrew for staff group.

= AUTHOR

Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>

EOF
}

if [ $1 ]; then
    print_help
    exit 0
fi

if  [ ! `id -u` = 0 ]; then
	echo "need root privilege!"
	exit 1
fi

for dir in /usr/local /Library/Caches/Homebrew /opt/homebrew-cask ; do
    if [ -d $dir ] ; then
        echo "chgrp -R staff $dir"
        sudo chgrp -R staff $dir
        echo "chmod -R g+w $dir"
        sudo chmod -R g+w $dir
    fi
done
