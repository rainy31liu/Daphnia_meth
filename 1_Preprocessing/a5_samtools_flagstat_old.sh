#!/bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=1G
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd samtools-1.17/bin/

i=$1

echo "Starting flagstat for sample D${i}"

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.bam

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.sorted.dup.bam

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.sorted.dup.filt.bam

echo "Finished flagstat for sample D${i}"