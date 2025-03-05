#! /bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i=$1

input_dir="/u/project/pellegrini/rainyliu/Daphnia/cgmap_old"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mstat_old"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mstat for sample D${i}"

input_file="${input_dir}/D${i}.filt.CGmap.gz"
output_file="${output_dir}/D${i}.filt.mstat.txt"

${cgmaptools} mstat -i "${input_file}" > "${output_file}"

echo "Finished mstat for sample D${i}"