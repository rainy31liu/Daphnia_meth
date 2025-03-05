#!/bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=10G
#$ -pe shared 4
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

cd samtools-1.17/bin/

i=$1

./samtools view "/u/project/pellegrini/rainyliu/Daphnia/mito_reads/S${i}.mito.bam" | awk '
BEGIN {
    OFS = "\t";
}
{
    read_name = $1;               # Read Name
    as_score = -1;                # Default AS score
    cigar = $6;                   # CIGAR string
    aligned_length = 0;           # Initialize aligned length
    is_unmapped = ($3 == "*");    # Unmapped reads have "*" in reference name

    # Extract AS score from optional fields
    for (j=12; j<=NF; j++) {
        if ($j ~ /^AS:i:/) {
            split($j, as_field, ":");
            as_score = as_field[3];
        }
    }

    # Compute aligned length from CIGAR string (sum of M & D)
    match_cigar = cigar;
    while (match_cigar ~ /[0-9]+[MD]/) {
        match_cigar_length = match(match_cigar, /[0-9]+[MD]/);
        aligned_length += substr(match_cigar, RSTART, RLENGTH - 1);
        sub(/[0-9]+[MD]/, "", match_cigar);
    }

    # Print unmapped reads separately
    if (is_unmapped || aligned_length == 0) {
        print read_name > "/u/project/pellegrini/rainyliu/Daphnia/mito_reads/S'"${i}"'.mito.unmapped_reads.txt";
        next;
    }

    # Compute Normalized AS Score
    normalized_as = as_score / aligned_length;

    # Print properly aligned reads
    print read_name, as_score, aligned_length, normalized_as > "/u/project/pellegrini/rainyliu/Daphnia/mito_reads/S'"${i}"'.mito.normalized_as_scores.txt";
}'
