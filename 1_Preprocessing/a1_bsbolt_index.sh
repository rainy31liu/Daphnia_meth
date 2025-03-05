#! /bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

python3 -m bsbolt Index -G /u/project/pellegrini/rainyliu/Daphnia/fasta/Daphnia_magna_full.fasta -DB /u/project/pellegrini/rainyliu/Daphnia/index/
