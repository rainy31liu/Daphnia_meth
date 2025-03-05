#!/bin/bash
#$ -l h_rt=4:00:00
#$ -l h_data=10G
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd samtools-1.17/bin/

i=$1

echo "Starting flagstat for sample S${i}"

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.bam

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.dup.bam

./samtools flagstat /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.dup.filt.bam

echo "Finished flagstat for sample S${i}"