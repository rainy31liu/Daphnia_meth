#! /bin/bash
#$ -l h_rt=180:00:00
#$ -pe shared 10
#$ -l h_data=10G
#$ -l highp
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia


. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

python3 -m bsbolt Align -DB /u/project/pellegrini/rainyliu/Daphnia/index -F1 /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S1_R1.fastq.gz -F2 /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S1_R2.fastq.gz -t 10 -OT 10 -O /u/project/pellegrini/rainyliu/Daphnia/bam_new/S1.new

python3 -m bsbolt Align -DB /u/project/pellegrini/rainyliu/Daphnia/index -F1 /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S2_R1.fastq.gz -F2 /u/project/pellegrini/rainyliu/Daphnia/fastq_new/S2_R2.fastq.gz -t 10 -OT 10 -O /u/project/pellegrini/rainyliu/Daphnia/bam_new/S2.new
