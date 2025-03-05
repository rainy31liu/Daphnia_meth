#! /bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=32G
#$ -pe shared 10
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia
#$ -M $rainyliu31@g.ucla.edu
#$ -m bea

. /u/local/Modules/default/init/modules.sh
module load conda
conda activate /u/home/r/rainyliu/miniconda3/envs/pelle

cd /u/project/pellegrini/rainyliu/Daphnia
python3 ./script/d4_epigenetic_clocks.py
