#! /bin/bash
#$ -l h_rt=48:00:00
#$ -l h_data=2G
#$ -pe shared 4
#$ -l highp
#$ -o /u/home/r/rainyliu/project-pellegrini/Daphnia
#$ -e /u/home/r/rainyliu/project-pellegrini/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

i=$1

echo "Starting alignment for sample ${i}"

python3 -m bsbolt Align -DB /u/project/pellegrini/rainyliu/Daphnia/index \
-F1 /u/project/pellegrini/rainyliu/Daphnia/fastq_old/Dap-${i}_S${i}_L001_R1_001.fastq.gz \
-F2 /u/project/pellegrini/rainyliu/Daphnia/fastq_old/Dap-${i}_S${i}_L001_R2_001.fastq.gz \
-O /u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.new

echo "Finished alignment for sample D${i}"
