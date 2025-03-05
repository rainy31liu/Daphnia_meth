#!/bin/bash
#$ -l h_rt=00:30:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i=$1

echo "Starting mec stat for S${i}"

/u/home/r/rainyliu/cgmaptools-master/cgmaptools mec stat \
    -i /u/project/pellegrini/rainyliu/Daphnia/cgmap_new/S${i}.CGmap.gz \
    > /u/project/pellegrini/rainyliu/Daphnia/mec_stat_new/S${i}.mec.txt

/u/home/r/rainyliu/cgmaptools-master/cgmaptools mec stat \
    -i /u/project/pellegrini/rainyliu/Daphnia/cgmap_new/S${i}.filt.CGmap.gz \
    > /u/project/pellegrini/rainyliu/Daphnia/mec_stat_new/S${i}.filt.mec.txt

echo "Finished mec stat for S${i}"