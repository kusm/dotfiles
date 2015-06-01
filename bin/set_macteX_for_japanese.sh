#!/bin/bash
#
# - set_MacTeX_for_Japanese
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

set -e

print_help(){
    cat <<EOF
= NAME

set_MacTeX_for_Japanese - basic setup for pLaTex, upLateX

= SYNOPSIS

 % set_MacTeX_for_Japanese

= DESCRIPTION

set_MacTeX_for_Japanese is simple shell script in order
to set Hiragino Font for pTeX, upTeX.

= AUTHOR

Youhei SASAKI <uwabami@math.kyoto-u.ac.jp>

EOF
}

if [ $1 ]; then
    print_help
    exit 0
fi

TEXMFLOCAL=`kpsewhich -var-value=TEXMFLOCAL`
GSRESDIR=`gs -h | grep Resource | tail -1 | awk '{print $1}' | sed 's/\/Font//'`

mktexmfconf(){
    local TEXMFLOCAL=$1
    [ ! -d $TEXMFLOCAL/web2c ] && mkdir $TEXMFLOCAL/web2c
    cat <<EOF > $TEXMFLOCAL/web2c/texmf.cnf
shell_escape_commands = \\
bibtex,bibtex8,bibtexu,upbibtex,biber,\\
kpsewhich,\\
makeindex,texindy,\\
mpost,upmpost,\\
repstopdf,epspdf,extractbb
EOF
    return 0
}

mktlmgrconf(){
    local TEXMFLOCAL=$1
    [ ! -d $TEXMFLOCAL/tlmgr ] && mkdir $TEXMFLOCAL/tlmgr
    cat <<EOF > $TEXMFLOCAL/tlmgr/conf
persistent-downloads = 0
auto-remove = 1
EOF
    return 0
}

mkfontlink(){
    local TEXMFLOCAL=$1
    [ ! -d $TEXMFLOCAL/fonts/opentype/public/hiragino ] && \
        mkdir -p $TEXMFLOCAL/fonts/opentype/public/hiragino
    (
        cd $TEXMFLOCAL/fonts/opentype/public/hiragino
        [ ! -L HiraMinPro-W3.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ明朝 Pro W3.otf" HiraMinPro-W3.otf
        [ ! -L HiraMinPro-W6.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ明朝 Pro W6.otf" HiraMinPro-W6.otf
        [ ! -L HiraMaruPro-W4.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ丸ゴ Pro W4.otf" HiraMaruPro-W4.otf
        [ ! -L HiraKakuPro-W3.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" HiraKakuPro-W3.otf
        [ ! -L HiraKakuPro-W6.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" HiraKakuPro-W6.otf
        [ ! -L HiraKakuStd-W8.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Std W8.otf" HiraKakuStd-W8.otf
        [ ! -L HiraMinProN-W3.otf ] && \
            ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W3.otf" HiraMinProN-W3.otf
        [ ! -L HiraMinProN-W6.otf ] && \
            ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W6.otf" HiraMinProN-W6.otf
        [ ! -L HiraMaruProN-W4.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ丸ゴ ProN W4.otf" HiraMaruProN-W4.otf
        [ ! -L HiraKakuProN-W3.otf ] && \
            ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W3.otf" HiraKakuProN-W3.otf
        [ ! -L HiraKakuProN-W6.otf ] && \
            ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W6.otf" HiraKakuProN-W6.otf
        [ ! -L HiraKakuStdN-W8.otf ] && \
            ln -s "/Library/Fonts/ヒラギノ角ゴ StdN W8.otf" HiraKakuStdN-W8.otf
        [ ! -L YuMincho-Medium.otf ] && \
            ln -s "/Library/Fonts/Yu Mincho Medium.otf" YuMincho-Medium.otf
        [ ! -L YuMincho-Demibold.otf ] && \
            ln -s "/Library/Fonts/Yu Mincho Demibold.otf" YuMincho-Demibold.otf
        [ ! -L YuGothic-Medium.otf ] && \
            ln -s "/Library/Fonts/Yu Gothic Medium.otf" YuGothic-Medium.otf
        [ ! -L YuGothic-Bold.otf ] && \
            ln -s "/Library/Fonts/Yu Gothic Bold.otf" YuGothic-Bold.otf
    )
    return 0
}

mkgsfontspec(){
    local fontname=$1
	cat <<EOT > $fontname-H
/${fontname}-H
/H /CMap findresource
[/${fontname} /CIDFont findresource]
composefont pop
EOT
}


setupgsfont(){
    local GSRESDIR=$1
    [ ! -d $GSRESDIR/CIDFont ] && mkdir -p $GSRESDIR/CIDfont
    [ ! -d $GSRESDIR/Font ] && mkdir -p $GSRESDIR/Font
    (
        cd $GSRESDIR/CIDFont
        [ -f HiraMinPro-W3 ] || \
            ln -s "/Library/Fonts/ヒラギノ明朝 Pro W3.otf" HiraMinPro-W3
        [ -f HiraMinPro-W6 ] || \
            ln -s "/Library/Fonts/ヒラギノ明朝 Pro W6.otf" HiraMinPro-W6
        [ -f HiraMaruPro-W4 ] || \
            ln -s "/Library/Fonts/ヒラギノ丸ゴ Pro W4.otf" HiraMaruPro-W4
        [ -f HiraKakuPro-W3 ] || \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" HiraKakuPro-W3
        [ -f HiraKakuPro-W6 ] || \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" HiraKakuPro-W6
        [ -f HiraKakuStd-W8 ] || \
            ln -s "/Library/Fonts/ヒラギノ角ゴ Std W8.otf" HiraKakuStd-W8
        [ -f HiraMinProN-W3 ] || \
            ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W3.otf" HiraMinProN-W3
        [ -f HiraMinProN-W6 ] || \
            ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W6.otf" HiraMinProN-W6
        [ -f HiraMaruProN-W4 ] || \
            ln -s "/Library/Fonts/ヒラギノ丸ゴ ProN W4.otf" HiraMaruProN-W4
        [ -f HiraKakuProN-W3 ] || \
            ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W3.otf" HiraKakuProN-W3
        [ -f HiraKakuProN-W6 ] || \
            ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W6.otf" HiraKakuProN-W6
        [ -f HiraKakuStdN-W8 ] || \
            ln -s "/Library/Fonts/ヒラギノ角ゴ StdN W8.otf" HiraKakuStdN-W8
    )
    (
        cd $GSRESDIR/Font
        for f in HiraMinPro-W3 HiraMinPro-W6 HiraMaruPro-W4 HiraKakuPro-W3 HiraKakuPro-W6 HiraKakuStd-W8 HiraMinProN-W3 HiraMinProN-W6 HiraMaruProN-W4 HiraKakuProN-W3 HiraKakuProN-W6 HiraKakuStdN-W3 ; do
            [ ! -f $f-H ] && mkgsfontspec $f
        done
    )
    ( echo <<EOF_cidfmap > $GSRESDIR/Init/cidfmap
%%% aliases
/Ryumin-Light                 /HiraMinProN-W3              ;
/Ryumin-Medium                /HiraMinProN-W3              ;
/FutoMinA101-Bold             /HiraMinProN-W6              ;
/MidashiMin-MA31              /HiraMinProN-W6              ;
/GothicBBB-Medium             /HiraKakuProN-W3             ;
/FutoGoB101-Bold              /HiraKakuProN-W6             ;
/MidashiGo-MB31               /HiraKakuStdN-W8             ;
/Jun101-Light                 /HiraMaruProN-W4             ;
/HeiseiMin-W3                 /Ryumin-Light                ;
/HeiseiKakuGo-W5              /GothicBBB-Medium            ;
/HiraMinStdN-W2               /MS-Mincho                   ;
/KozMinPr6N-Regular           /Ryumin-Light                ;
/KozMinPro-Regular            /KozMinPr6N-Regular          ;
/KozMinPro-Regular-Acro       /KozMinPro-Regular           ;
/HeiseiMin-W3-Acro            /KozMinPro-Regular-Acro      ;
/KozGoPr6N-Medium             /GothicBBB-Medium            ;
/KozGoPro-Medium              /KozGoPr6N-Medium            ;
/KozGoPro-Medium-Acro         /KozGoPro-Medium             ;
/HeiseiKakuGo-W5-Acro         /KozGoPro-Medium-Acro        ;
EOF_cidfmap
    )
    return 0
}

echo "Create font symlink"
mkfontlink $TEXMFLOCAL
echo "Create texmf.cnf"
mktexmfconf $TEXMFLOCAL
echo "Create tlmgr/config"
mktlmgrconf $TEXMFLOCAL
echo "Setup Ghostscript font config"
setupgsfont $GSRESDIR
echo "mktexlsr"
mktexlsr
echo "updmap-sys --setoption kanjiEmbed hiragino"
updmap-sys --setoption kanjiEmbed hiragino
