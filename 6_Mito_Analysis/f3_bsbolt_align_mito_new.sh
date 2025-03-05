#! /bin/bash
#$ -l h_rt=4:00:00
#$ -pe shared 10
#$ -l h_data=10G
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6
i=$1

python3 -m bsbolt Align -DB /u/project/pellegrini/rainyliu/Daphnia/index_nuclear \
    -F1 /u/project/pellegrini/rainyliu/Daphnia/mito_reads/S${i}_R1.mito.fastq.gz \
    -F2 /u/project/pellegrini/rainyliu/Daphnia/mito_reads/S${i}_R2.mito.fastq.gz \
    -t 10 -OT 10 -O /u/project/pellegrini/rainyliu/Daphnia/mito_reads/S${i}.mito

echo "finish"
