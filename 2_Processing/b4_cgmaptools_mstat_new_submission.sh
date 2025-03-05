
. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

for i in {1..2}
do
    qsub -pe shared 10 /u/project/pellegrini/rainyliu/Daphnia/script/b4_cgmaptools_mstat_new.sh ${i}
done

