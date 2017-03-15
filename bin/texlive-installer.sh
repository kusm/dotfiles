#!/bin/bash
#
# - texlive-installer
#
# Written by Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>
#
# Note: We want to declare full-permissive license(e.g. WTFPL). But some
#       countries and associations prohibit such kind of manner. Thus we
#       declare it for MIT license.
#
# Memo: Basic Information @see TeX Wiki - Mac
#       URL: http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Mac
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


print_help(){
    cat <<EOF
= NAME

texlive-installer - Install basic TeX/pTeX packages using tlmgr

= SYNOPSIS

 % texlive-installer

= DESCRIPTION

texlive-installer is simple shell script in order to install basic
TeX/pTeX packages using tlmgr.

= AUTHOR

Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>

EOF
}

if [ $1 ]; then
    print_help
    exit 0
fi

sudo fix_homebrew_permssion_for_multiuser.sh

TEXMFLOCAL=`kpsewhich -var-value=TEXMFLOCAL`
mktlmgrconf(){
    local TEXMFLOCAL=$1
    [ ! -d $TEXMFLOCAL/tlmgr ] && mkdir $TEXMFLOCAL/tlmgr
    cat <<EOF > $TEXMFLOCAL/tlmgr/conf
persistent-downloads = 0
auto-remove = 1
EOF
    return 0
}

echo "Create tlmgr/config"
mktlmgrconf $TEXMFLOCAL

tlmgr option repository http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/
tlmgr update --self --all --no-persistent-downloads
tlmgr install collection-basic --no-persistent-downloads
tlmgr install collection-latex --no-persistent-downloads
tlmgr install collection-latexrecommended --no-persistent-downloads
tlmgr install collection-latexrextra --no-persistent-downloads
tlmgr install collection-metapost --no-persistent-downloads
tlmgr install collection-mathextra --no-persistent-downloads
tlmgr install collection-luatex --no-persistent-downloads
tlmgr install collection-langjapanese --no-persistent-downloads
tlmgr install collection-pictures --no-persistent-downloads
tlmgr install collection-pstricks --no-persistent-downloads
tlmgr install collection-science --no-persistent-downloads
tlmgr install collection-xetex --no-persistent-downloads
tlmgr install collection-fontsextra --no-persistent-downloads
tlmgr install collection-bibtexextra --no-persistent-downloads
tlmgr install collection-publishers --no-persistent-downloads
tlmgr install latexmk lacheck --no-persistent-downloads



