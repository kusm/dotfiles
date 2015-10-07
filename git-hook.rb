#!/usr/bin/env ruby
# -*- mode: ruby; coding: utf-8-unix; indent-tabs-mode: nil -*-
#
# Copyright(C) Youhei SASAKI All rights reserved.
# $Lastupdate: 2012/08/19 22:07:24$
# License: MIT/X11
#
if ARGV[0]
  debug = true
end
dot_dirs = "."
git_files = `git --git-dir=#{dot_dirs}/.git ls-files`.split("\n")
filelist = Array.new
git_files.each do |f|
  fullpath = File::expand_path(f, dot_dirs)
  filelist.push(fullpath)
  filelist.push(File::dirname(fullpath))
end
filelist.uniq.sort.each do |f|
  if FileTest::directory?(f)
    p "File::chmod(0700, #{f})" if debug
    File::chmod(0700, f)
  elsif f =~ /\.rb$|\.awk$|\.sh$|-nkf$/
    p "File::chmod(0700, #{f})" if debug
    File::chmod(0700, f)
  else
    p "File::chmod(0600, #{f})" if debug
    File::chmod(0600, f)
  end
end
