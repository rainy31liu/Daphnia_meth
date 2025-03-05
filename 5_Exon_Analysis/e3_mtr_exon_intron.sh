#!/bin/bash
#$ -l h_rt=12:00:00
#$ -l h_data=5G
#$ -l highp
#$ -pe shared 10
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load R

cd /u/project/pellegrini/rainyliu/Daphnia/script
echo "start"
Rscript e3_mtr_exon_intron.R
echo "finish"