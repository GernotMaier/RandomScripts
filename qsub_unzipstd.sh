#!/bin/bash
# script to convert simulation files in bzip to zst
#
# uses batch system (called from unzipstd.sh)
#
# requires zst to be installed
#

DDIR=$1
FFIL=$2
ODIR=$3

SDIR="$TMPDIR/"

if [ -e $DDIR/${FFIL}.zst ]
then
   exit
fi

if [ -e $DDIR/$FFIL.bz2 ]
then
   cp -v $DDIR/$FFIL.bz2 $SDIR/
   # calculate md5sum
   md5sum $SDIR/$FFIL.bz2 > $ODIR/$FFIL.md5sum

   # bunzip decompress
   bunzip2 -v -c $SDIR/$FFIL.bz2 > $SDIR/${FFIL}

   # zst compress
   /afs/ifh.de/group/cta/VERITAS/software/bin/zstd -vv -f $SDIR/${FFIL} $SDIR/$FFIL.zst

   # cp to required output directory
   cp -v $SDIR/$FFIL.zst $ODIR/$FFIL.zst
fi
