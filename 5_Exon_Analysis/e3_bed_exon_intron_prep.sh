#!/bin/bash
#$ -l h_rt=12:00:00
#$ -l h_data=5G
#$ -l highp
#$ -pe shared 10
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

code_dir="/u/home/r/rainyliu/cgmaptools-master/src"
cd /u/home/r/rainyliu/project-pellegrini/Daphnia/cgmap_new_CG

python ${code_dir}/Sort_chr_pos.py -i S1.filt.CGmap.gz -c 1 -p 3 -o S1.filt.sort.CGmap.gz
