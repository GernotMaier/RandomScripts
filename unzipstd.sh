#!/bin/bash
# script to convert simulation files in bzip to zst
#
# uses batch system (requires qsub_unzipstd.sh)
#
# requires zst to be installed
#

# zst files are written to this directory
ODIR="/lustre/fs19/group/cta/VERITAS/simulations/V6_FLWO/CARE_June1702_ATM61/"
# log files are written here
LDIR="/lustre/fs23/group/cta/tempVTS/CARE_April2020_ATM61/"
# bz2 files are located here
LL=`find ./ -name "gamma*.bz2"`


for L in $LL
do
   echo $L
   O=`basename $L .bz2`

   if [ -e $ODIR/${O}.zst ]
   then
      echo "ZST found: ${O}"
      continue
   fi

   echo "Submitting"
   qsub -l h_rt=31:30:00 -o $LDIR -e $LDIR -l tmpdir_size=250G qsub_unzipstd.sh $DDIR $O $ODIR

   exit

done
