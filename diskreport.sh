#!/bin/bash
#
# prepares a disk report for lustres
# including a total summary

header=$( lfs quota -h -g cta /lustre/fs18 | sed -n 2p)
tot_used=0
tot_quota=0

echo $header

for L in 18 19 20 21 22 23
do
   fs=$( lfs quota -h -g cta /lustre/fs${L} | tail -n 1)
   fs_used=$(echo $fs | awk '{print $2}')
   fs_quota=$(echo $fs | awk '{print $3}')
   #fs_used=${fs_used::-1}
   #fs_quota=${fs_quota::-1}
   fs_ratio=$(awk "BEGIN {printf \"%.2f\",${fs_used::-1}/${fs_quota::-1}}")
   echo "$fs disk usage: $fs_ratio%"
   tot_used=$(awk "BEGIN {printf \"%.2f\",${fs_used::-1}+${tot_used}}")
   tot_quota=$(awk "BEGIN {printf \"%.2f\",${fs_quota::-1}+${tot_quota}}")
done
echo "==============================="
echo "Available quota: $tot_quota Tb"
echo "Used: $tot_used Tb"
echo "Occupied: $(awk "BEGIN {printf \"%.2f\",${tot_used}/${tot_quota}}")%"
