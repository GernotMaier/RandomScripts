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

rm -f $ODIR/$FFIL.zst.log
touch $ODIR/$FFIL.zst.log
echo "Data directory: $DDIR" >> $ODIR/$FFIL.zst.log
echo "File: $FFIL" >> $ODIR/$FFIL.zst.log
echo "Output: $ODIR" >> $ODIR/$FFIL.zst.log

if [ -e $DDIR/$FFIL.bz2 ]
then
   cp -v $DDIR/$FFIL.bz2 $SDIR/ >> $ODIR/$FFIL.zst.log
   # calculate md5sum
   rm -f $ODIR/$FFIL.md5sum
   md5sum $SDIR/$FFIL.bz2 > $ODIR/$FFIL.md5sum

   # bunzip decompress
   bunzip2 -v -c $SDIR/$FFIL.bz2 > $SDIR/${FFIL}

   # zst compress
   /afs/ifh.de/group/cta/VERITAS/software/bin/zstd -vv -f $SDIR/${FFIL} $SDIR/$FFIL.zst

   # cp to required output directory
   cp -v -f $SDIR/$FFIL.zst $ODIR/$FFIL.zst
else
   echo "File $DDIR/$FFIL.bz2 not found" >> $ODIR/$FFIL.zst.log
fi
