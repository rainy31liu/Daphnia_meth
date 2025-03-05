#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i=$1

input_dir="/u/project/pellegrini/rainyliu/Daphnia"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mfg_old"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mfg for sample S${i} transcript"

for j in "CG"
do
    echo "Starting mfg for sample D${i} ${j} transcript"
    gunzip -c "${input_dir}/cgmap_old/D${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${input_dir}/bed/transcript.fragreg.txt" \
        -x ${j} -c 1 > "${output_dir}/D${i}.${j}.mfg.txt"
done
