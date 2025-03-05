#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd /u/project/pellegrini/rainyliu/Daphnia/dmr_age/
/u/home/r/rainyliu/metilene_v0.2-8/metilene -a young -b old -m 5 -d 0.001 -t 4 -f 1 old.young.txt
