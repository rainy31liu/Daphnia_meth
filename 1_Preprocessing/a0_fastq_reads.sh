#! /bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=12G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

for i in {1..2}
do
    echo "Number of reads in Sample S${i} in R1: "
    zcat /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S${i}_R1.fastq.gz | echo $((`wc -l`/4))
    echo "Number of reads in Sample S${i} in R2: "
    zcat /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S${i}_R2.fastq.gz | echo $((`wc -l`/4))
    echo "Finished assessing number of reads for sample S${i}"
done

for i in {1..16}
do
    echo "Number of reads in Sample S${i} in R1: "
    zcat /u/project/pellegrini/rainyliu/Daphnia/fastq_old/Dap-${i}_S${i}_L001_R1_001.fastq.gz | echo $((`wc -l`/4))
    echo "Number of reads in Sample S${i} in R2: "
    zcat /u/project/pellegrini/rainyliu/Daphnia/fastq_old/Dap-${i}_S${i}_L001_R2_001.fastq.gz | echo $((`wc -l`/4))
    echo "Finished assessing number of reads for sample D${i}"
done
