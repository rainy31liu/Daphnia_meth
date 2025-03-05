#!/bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i=$1
. /u/local/Modules/default/init/modules.sh
module load R

cd /u/project/pellegrini/rainyliu/Daphnia/script
Rscript b1_cgmap_filter_old.R ${i}
