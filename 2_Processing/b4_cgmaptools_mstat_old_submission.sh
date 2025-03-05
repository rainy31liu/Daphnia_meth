
. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

for i in {1..16}
do
    qsub -pe shared 4 /u/project/pellegrini/rainyliu/Daphnia/script/b4_cgmaptools_mstat_old.sh ${i}
done