#! /bin/bash
#$ -l h_rt=24:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

i=$1

echo "Starting call methylation for sample D${i}"

python3 -m bsbolt CallMethylation \
    -I /u/project/pellegrini/rainyliu/Daphnia/bam_old/D${i}.sorted.dup.filt.bam \
    -O /u/project/pellegrini/rainyliu/Daphnia/cgmap_old/D${i} \
    -DB /u/project/pellegrini/rainyliu/Daphnia/index \
    -verbose \
    -IO \
    -min 10 \
    -t 10 \

echo "Finished call methylation for sample D${i}"
