#!/bin/bash
#$ -l h_rt=3:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load R

cd /u/project/pellegrini/rainyliu/Daphnia/script
Rscript c2_cgmap_bed_old.R
