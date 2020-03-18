#! /bin/bash
#
# delete list of jobs
#
#

if [ ${#1} -eq 0 ]
then
   echo "usage: qdel_job.sh <list of job IDs>"
   exit
fi

LLT=`cat $1`

for i in $LLT
do
echo $i
   qdel $i
done

exit
