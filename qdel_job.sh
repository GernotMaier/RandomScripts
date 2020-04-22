#! /bin/bash
#
# delete a range of jobs
#
# Gernot Maier (gm@ast.leeds.ac.uk) 17/01/2006
#

if [ ${#1} -eq 0 ]
then
   echo "usage: qdel_job.sh <job name>"
   exit
fi

LLT=`qstat | grep maierg |  grep $1 | awk '{print $1; }' | sort -r | sort -u`

# get a unique list
# LLT=$(echo $LLLT | tr ' ' '\n' | sort -nu) 

for i in $LLT
do
echo $i
   qdel $i
#   qmod -cj $i
done

exit
