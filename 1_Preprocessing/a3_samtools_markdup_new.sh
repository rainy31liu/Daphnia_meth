#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=30G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd /u/home/r/rainyliu/samtools-1.17/bin/

i=$1

echo "Starting removal of duplicate for sample S${i}"

./samtools sort -@ 10 -n -o /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.bam -O BAM /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.bam

./samtools fixmate -p -m /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.bam -O BAM /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.fixmate.bam --threads 10

rm /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.bam

./samtools sort -@ 10 -o /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.fixmate.bam -O BAM /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.fixmate.bam

./samtools markdup -r /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.fixmate.bam /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.dup.bam

rm /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.fixmate.bam

./samtools index -@ 10 -b /u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.dup.bam

echo "Finished removal of duplicate for sample S${i}"