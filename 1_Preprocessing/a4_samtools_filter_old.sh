#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd samtools-1.17/bin/

i=$1

input_prefix="/u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.sorted.dup"
echo "Starting to process ${input_prefix}"

./samtools view -H "${input_prefix}.bam" > "${input_prefix}.filt.sam"
./samtools view "${input_prefix}.bam" | awk '{
    cigar = $6; 
    sum = 0; 
    while (match(cigar, /([0-9]+)M/)) {
        sum += substr(cigar, RSTART, RLENGTH-1);
        cigar = substr(cigar, RSTART+RLENGTH);
    }
    if (sum >= 50 || substr($0, 1, 1) == "@") {
        print;
    }
}' >> "${input_prefix}.filt.sam"
./samtools view -bS -o "${input_prefix}.filt.bam" "${input_prefix}.filt.sam"
./samtools index "${input_prefix}.filt.bam" "${input_prefix}.filt.bam.bai"
rm ${input_prefix}.filt.sam

echo "Finished processing ${input_prefix}"
