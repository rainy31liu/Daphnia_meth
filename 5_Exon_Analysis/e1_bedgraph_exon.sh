#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=10G
#$ -l highp
#$ -pe shared 10
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load R

cd /u/project/pellegrini/rainyliu/Daphnia/script
Rscript e1_bedgraph_exon.R
