#!/bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=10G
#$ -pe shared 4
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd samtools-1.17/bin/

i=$1

echo "Starting to filter ${input_prefix} for mitochondrial sequences"
input_prefix="/u/project/pellegrini/rainyliu/Daphnia/bam_new/S${i}.sorted.dup.filt"

./samtools view -b -h "${input_prefix}.bam" MH683648.1 >  "${input_prefix}.mito.bam"

echo "Finished filtering ${input_prefix} for mitochondrial sequences"
