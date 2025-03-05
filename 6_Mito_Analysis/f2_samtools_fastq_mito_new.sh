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
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mito_reads"

./samtools view "${input_prefix}.mito.bam" | cut -f1 | sort | uniq > "${output_dir}/S${i}.read.names.txt"

zgrep -A 3 -F -f "${output_dir}/S${i}.read.names.txt" /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S${i}_R1.fastq.gz | grep -v "^--$" > "${output_dir}/S${i}_R1.mito.fastq"
zgrep -A 3 -F -f "${output_dir}/S${i}.read.names.txt" /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S${i}_R2.fastq.gz | grep -v "^--$" > "${output_dir}/S${i}_R2.mito.fastq"

gzip "${output_dir}/S${i}_R1.mito.fastq" "${output_dir}/S${i}_R2.mito.fastq"

echo "Finished filtering ${input_prefix} for mitochondrial sequences"
